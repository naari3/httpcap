# frozen_string_literal: true

RSpec.describe HTTPcap::HTTPFlow do
  subject { HTTPcap::HTTPFlow.new(request, response) }
  let(:request) { 'request' }
  let(:response) { 'response' }

  it 'has a request and response' do
    expect(subject.request).to eq request
    expect(subject.response).to eq response
  end
end
