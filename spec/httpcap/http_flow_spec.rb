# frozen_string_literal: true

RSpec.describe HTTPcap::HTTPFlow do
  subject { HTTPcap::HTTPFlow.new(request, response) }
  let(:request) { HTTPcap::Request.new("GET / HTTP/1.1\r\nHost: example.com\r\n\r\n") }
  let(:response) { HTTPcap::Response.new("HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 0\r\n\r\n") }

  it 'has a request and response' do
    expect(subject.request).to eq request
    expect(subject.response).to eq response
  end
end
