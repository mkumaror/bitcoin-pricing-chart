namespace :fetch do
  desc "TODO"
  task latest_pricing: :environment do
  	Services::Pricing.new.fetch_latest_pricing
  end

end
