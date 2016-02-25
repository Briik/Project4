require 'nokogiri'
require 'open-uri'

Contract.destroy_all
Agency.destroy_all

doc = Nokogiri::XML(open('http://www.defense.gov/DesktopModules/ArticleCS/RSS.ashx?max=3650&ContentType=400&Site=727')) do |config|
    config.options = Nokogiri::XML::ParseOptions::NONET
end

days = doc.xpath('//item')

# works for 98.7% of days.
def findAgency(nok)
    agencyName = /[A-Z\. ]+/.match(nok.inner_text.split('CONTRACTS')[1].to_s).to_s
    theOne = Agency.find_by_name agencyName
    if theOne === nil
        return theOne
    else
        return theOne.id
    end
end

for day in days do
    Agency.create(name: /[A-Z\. ]+/.match(day.xpath('description').inner_text.split('CONTRACTS')[1].to_s))
end

for day in days do

    int_money = /(?=[$])[$,\d]{1,16}/.match(day.xpath('description').to_s).to_s
    if int_money
        money = int_money[1..-1].to_s.split(',').join('')
    elsif !int_money
        money = nil
    end

    Agency.create(name: day.xpath('description').to_s.split('CONTRACTS	')[1].to_s.split('	')[0])

    Contract.create(title: day.xpath('title').to_s.split("\n")[1],
                    link: day.xpath('link').to_s.split('>')[1].split('<')[0],
                    description: day.xpath('description').to_s.split("\n")[1],
                    pubdate: DateTime.httpdate(day.xpath('pubDate').to_s.split('>')[1].split('<')[0]),
                    dollar_amt: money,
                    creator: day.xpath('dc:creator').to_s.split('>')[1].split('<')[0],
                    agency_id: findAgency(day.xpath('description')))
end

agencies = Agency.all
contracts = Contract.all
