################################################################################
# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'spec_helper'

provider_class = Puppet::Type.type(:oneview_volume_template).provider(:ruby)

describe provider_class do
  let(:resource) do
    Puppet::Type.type(:oneview_volume_template).new(
      name: 'Volume Template',
      ensure: 'present',
      data:
          {
            'name' => 'ONEVIEW_PUPPET_TEST'
          }
    )
  end

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  context 'given the minimum parameters' do
    it 'should be an instance of the provider Ruby' do
      expect(provider).to be_an_instance_of Puppet::Type.type(:oneview_volume_template).provider(:ruby)
    end

    it 'exists? should not find the volume template' do
      expect(provider.exists?).not_to be
    end

    it 'should return that the volume template was not found' do
      expect(provider.found).not_to be
    end

    it 'should not be able to return the list of connectable volume templates' do
      expect(provider.get_connectable_volume_templates).not_to be
    end
  end

  context 'given the create parameters' do
    let(:resource) do
      Puppet::Type.type(:oneview_volume_template).new(
        name: 'Volume Template',
        ensure: 'present',
        data:
            {
              'name'         => 'ONEVIEW_PUPPET_TEST',
              'description'  => 'Volume Template',
              'stateReason'  => 'None',
              'provisioning' => {
                'shareable'      => true,
                'provisionType'  => 'Thin',
                'capacity'       => '235834383322',
                'storagePoolUri' => '/rest/storage-pools/A42704CB-CB12-447A-B779-6A77ECEEA77D'
              }
            }
      )
    end

    it 'should create the volume template' do
      expect(provider.create).to be
    end
  end

  context 'given the minimum parameters' do
    it 'exists? should find the volume template' do
      expect(provider.exists?).to be
    end
    it 'should return that the volume template was found' do
      expect(provider.found).to be
    end

    it 'should return the list of connectable volume templates' do
      expect(provider.get_connectable_volume_templates).to be
    end

    it 'should drop the volume template' do
      expect(provider.destroy).to be
    end
  end
end
