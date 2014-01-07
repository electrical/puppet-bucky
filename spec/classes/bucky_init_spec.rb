require 'spec_helper'

describe 'bucky2', :type => 'class' do

  context "On Debian OS" do
    let :facts do
      {
        :operatingsystem => 'Debian'
      }
    end
   
    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.Debian' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
  end

   context "On Ubuntu OS" do
    let :facts do
      {
        :operatingsystem => 'Ubuntu'
      }
    end

    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.Debian' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
  
  end

  context "On CentOS OS " do
    let :facts do
      {
        :operatingsystem => 'CentOS'
      }
    end

    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
   
  end

  context "On RedHat OS " do
    let :facts do
      {
        :operatingsystem => 'Redhat'
      }
    end

    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
    
  end

  context "On Fedora OS " do
    let :facts do
      {
        :operatingsystem => 'Fedora'
      }
    end

    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
  
  end

  context "On Scientific OS " do
    let :facts do
      {
        :operatingsystem => 'Scientific'
      }
    end

    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
   
  end

  context "On Amazon OS " do
    let :facts do
      {
        :operatingsystem => 'Amazon'
      }
    end

    # init.pp
    it { should contain_class('bucky2::package') }
    it { should contain_class('bucky2::config') }
    it { should contain_class('bucky2::files') }
    it { should contain_class('bucky2::service') }

    # package.pp
    it { should contain_package('bucky2').with( { 'provider' => 'pip' } ) }

    # service.pp
    it { should contain_service('bucky2') }

    # files.pp
    it { should contain_file('bucky2_init').with( { 'source' => 'puppet:///modules/bucky2/etc/init.d/bucky2.RedHat' } ) }

    # config.pp
    it { should contain_file('/etc/bucky2') }
    it { should contain_file('bucky2_config') }
   
  end

  context "On an unknown OS" do
    let :facts do
      {
        :operatingsystem => 'Darwin'
      }
    end
 
    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

  context "Check Parameters" do
      
    let :facts do
      {
        :operatingsystem => 'Debian'
      }
    end

    context "No parameters set" do

      it do
        should contain_file('bucky2_config') \
          .with_content(/collectd_enabled = False/)
      end

      it do
        should contain_file('bucky2_config') \
          .with_content(/statsd_enabled = False/)
      end

      it do
        should contain_file('bucky2_config') \
          .with_content(/metricsd_enabled = False/)
      end

    end

    context "collectd_enabled => true" do
      let :params do
        {
          :collectd_enabled => true,
        }
      end

      it do
        should contain_file('bucky2_config') \
          .with_content(/collectd_enabled = True/)
      end

    end

    context "statsd_enabled => true" do
      let :params do
        {
          :statsd_enabled => true,
        }
      end

      it do
        should contain_file('bucky2_config') \
          .with_content(/statsd_enabled = True/)
      end

    end

    context "metricsd_enabled => true" do
      let :params do
        {
          :metricsd_enabled => true,
        }
      end

      it do
        should contain_file('bucky2_config') \
          .with_content(/metricsd_enabled = True/)
      end

    end

  end
 
end
