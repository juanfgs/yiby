# coding: utf-8
require "../lib/service"
require "json"
describe Service do
  it "returns  hash from requests" do
    service = Service.new "http://labs.bestwebdesigncompany.info/issues.json"
    expect(service.run()).to be_a(Hash)

  end

  it "raises exception for invalid uris" do
    service = Service.new "foobar"
    expect{service.run()}.to raise_error(ArgumentError)
  end

  it "adds parameters to the query" do
    service = Service.new "foobar"
    {:origin => "Don bosco 235 Paraná Entre Ríos", :destination => "San Martin 233 Paraná Entre Ríos", :sensor => false}.each do |x|
      service.add_param x
      expect(service.params).to include(x)
    end
  end

  it "clears its state when requested" do
    service = Service.new "foobar"
    {:origin => "Don bosco 235 Paraná Entre Ríos", :destination => "San Martin 233 Paraná Entre Ríos", :sensor => false}.each do |x|
      service.add_param x
      expect(service.params).to include(x)
    end
    service.reset_query()
    expect(service.params.count).to equal(0)
    expect(service.api_url.query).to equal(nil)
    
  end
  
end

  


