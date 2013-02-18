require 'spec_helper'

describe 'bucky', :type => 'class' do

  context "On a Debian OS" do
    let :facts do
      {
        :operatingsystem => 'Debian'
      }
    end
   
    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.Debian' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
  end

   context "On an Ubuntu OS" do
    let :facts do
      {
        :operatingsystem => 'Ubuntu'
      }
    end

    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.Debian' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
  
  end

  context "On a CentOS OS " do
    let :facts do
      {
        :operatingsystem => 'CentOS'
      }
    end

    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
   
  end

  context "On a RedHat OS " do
    let :facts do
      {
        :operatingsystem => 'Redhat'
      }
    end

    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
    
  end

  context "On a Fedora OS " do
    let :facts do
      {
        :operatingsystem => 'Fedora'
      }
    end

    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
  
  end

  context "On a Scientific OS " do
    let :facts do
      {
        :operatingsystem => 'Scientific'
      }
    end

    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
   
  end

  context "On a Amazon OS " do
    let :facts do
      {
        :operatingsystem => 'Amazon'
      }
    end

    # init.pp
    it { should contain_class('bucky::package') }
    it { should contain_class('bucky::config') }
    it { should contain_class('bucky::files') }
    it { should contain_class('bucky::service') }

    # package.pp
    it { should contain_package('bucky').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky') }

    # files.pp
    it { should contain_file('bucky_init').with( { 'source' => 'puppet:///modules/bucky/etc/init.d/bucky.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky') }
    it { should contain_file('bucky_config') }
   
  end

  context "On an unknown OS with no package name specified" do
    let :facts do
      {
        :operatingsystem => 'Darwin'
      }
    end
 
    it {
      expect { should raise_error(Puppet::Error) }
    }
  end
 
end
