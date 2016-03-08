class Contract < ActiveRecord::Base
    belongs_to :agency

    def users
        (User.where id: user_id).map
    end

    def agency
        Agency.find_by id: agency_id
    end

    # percent value of individual contract compared to ALL contracts
    def percent_val
        dollar_amt ? ((dollar_amt / Contract.sum(:dollar_amt)) * 100) : nil
    end

    def percent_of_agency
        dollar_amt ? ((dollar_amt / Contract.where({ agency_id: agency_id }).sum(:dollar_amt)) * 100) : nil
    end

    def self.daily_update
        require 'nokogiri'
        require 'open-uri'

        doc = Nokogiri::XML(open('http://www.defense.gov/DesktopModules/ArticleCS/RSS.ashx?max=1&ContentType=400&Site=727')) do |config|
            config.options = Nokogiri::XML::ParseOptions::NONET
        end

        days = doc.xpath('//item')
        for day in days do

            int_money = /(?=[$])[$,\d]{1,16}/.match(day.xpath('description').to_s).to_s
            if int_money
                money = int_money[1..-1].to_s.split(',').join('')
            elsif !int_money
                money = nil
            end

            Contract.create(title: day.xpath('title').to_s.split("\n")[1],
                            link: day.xpath('link').to_s.split('>')[1].split('<')[0],
                            description: day.xpath('description').to_s.split("\n")[1],
                            pubdate: DateTime.httpdate(day.xpath('pubDate').to_s.split('>')[1].split('<')[0]),
                            dollar_amt: money,
                            creator: day.xpath('dc:creator').to_s.split('>')[1].split('<')[0])
        end
    end
end
