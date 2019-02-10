# frozen_string_literal: true

RSpec.describe HTTPcap::Request do
  subject(:request) { HTTPcap::Request.new(http_request) }

  let(:http_request) { "#{method} #{path} HTTP/1.1\r\n#{headers.map { |k, v| "#{k}: #{v}" }.join("\r\n")}\r\n\r\n#{body}" }
  let(:method) { 'POST' }
  let(:path) { '/index.html' }
  let(:headers) do
    {
      'Host' => host,
      'Content-Type' => 'text/plain',
      'Content-Length' => body.size
    }
  end
  let(:host) { 'www.example.com' }
  let(:body) { 'hello, this is a test code.' }

  it 'receive raw http request' do
    subject
    expect(request.http_method).to eq method
    expect(request.url).to eq host + path
    expect(request.body).to eq body
    headers.keys do |k|
      expect(request.headers[k]).to eq headers[k]
    end
  end
end
