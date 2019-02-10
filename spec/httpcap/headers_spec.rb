# frozen_string_literal: true

RSpec.describe HTTPcap::Headers do
  let(:headers) { HTTPcap::Headers.new }

  describe '#stream' do
    subject { headers.stream(type, value) }
    let(:type) { HTTPcap::Headers::TYPE_FIELD }
    let(:value) { 'hoge' }

    context 'with different type' do
      it 'add value to bucket' do
        subject
        expect(headers.instance_variable_get('@bucket')).to eq [value]
      end
    end

    context 'with same type as last time' do
      before do
        headers.stream(type, value)
      end
      it 'concat value to last value from bucket' do
        subject
        expect(headers.instance_variable_get('@bucket')).to eq [value + value]
      end
    end
  end

  describe '#stream_complete' do
    subject { headers.stream_complete }
    before do
      headers.instance_variable_set('@bucket', bucket)
    end

    context 'only two value arrays on @bucket' do
      let(:content_hash) { { 'test' => '123', 'hoge' => 'fuga' } }
      let(:bucket) { content_hash.flatten }

      it 'make bucket hash, then merge to content' do
        subject
        expect(headers.instance_variable_get('@content')).to eq content_hash
      end
    end
  end
end
