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

Puppet::Type.newtype(:oneview_ethernet_network) do
  desc "Oneview's ethernet network"

  ensurable do
    defaultvalues

    # Creating the find operation for the ensure method
    newvalue(:found) do
      provider.found
    end

  end

  # Debug warning
  # Puppet.warning("Puppet has passed through the type")

  newparam(:name, :namevar => true) do
    desc "Ethernet network name"
  end

  newparam(:data) do
    desc "Ethernet network data hash containing all specifications for the
    network"
    validate do |value|
      unless value.class == Hash
        raise(ArgumentError, "Invalid Data Hash")
      end
    end
  end



end