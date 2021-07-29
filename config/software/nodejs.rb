#
# Copyright 2013-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "nodejs"

license "MIT"
license_file "LICENSE"
skip_transitive_dependency_licensing true

default_version "0.10.48"

dependency "python"

default_src_url = "https://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"

version "0.10.48" do
  source url: default_src_url, sha256: "27a1765b86bf4ec9833e2f89e8421ba4bc01a326b883f125de2f0b3494bd5549"
end

relative_path "node-v#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "#{install_dir}/embedded/bin/python ./configure" \
          " --prefix=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
