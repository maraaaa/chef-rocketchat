require 'spec_helper'

describe 'rocketchat::default_attributes' do
  describe 'on an ubuntu 14.04 system' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge('rocketchat::mongodb')
    end

    it 'sets the default user & group' do
      expect(chef_run.node['rocketchat']['user']).to eq('rocketchat')
      expect(chef_run.node['rocketchat']['group']).to eq('rocketchat')
    end

    it 'sets a installation directory' do
      expect(chef_run.node['rocketchat']['install_dir']).to eq('/srv/rocketchat')
    end

    it 'has a url' do
      expect(chef_run.node['rocketchat']['url']).to match(%r{https:.+(/download)})
    end

    it 'has a valid checksum' do
      expect(chef_run.node['rocketchat']['checksum']).to match(/\b(?:[a-fA-F0-9][\r\n]*){64}\b/)
    end

    it 'installs packages' do
      expect(chef_run.node['rocketchat']['dependencies']).to eq(%w(graphicsmagick curl build-essential g++))
    end
  end

  describe 'on a debian 7 system' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'debian', version: '7.11')
      runner.converge('rocketchat::mongodb')
    end

    it "node['rocketchat']['dependencies'] includes netcat" do
      expect(chef_run.node['rocketchat']['dependencies']).to include('netcat')
    end
  end

  describe 'on a CentOS 7 system' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge('rocketchat::mongodb')
    end

    it "node['rocketchat']['dependencies'] includes GraphicsMagick" do
      expect(chef_run.node['rocketchat']['dependencies']).to include('GraphicsMagick')
    end
  end
end
