every 1.day, :at => '6:30 pm' do
  runner "Contract.daily_update"
end
