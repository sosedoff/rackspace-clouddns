# Rackspace CloudDNS API Wrapper

A simple ruby library to communicate with Rackspace Cloud DNS service.

*The service is in beta at this moment.* 

## Installation

Install via rubygems: (**not published yet**):

    gem install rackspace-clouddns

Install via github:

    git clone git@github.com:sosedoff/rackspace-clouddns.git
    cd rackspace-clouddns
    bundle install
    gem build rackspace-clouddns.gemspec
    gem install rackspace-clouddns-0.1.0.gem

## Usage

Authentication:

    dns = CloudDns::Client.new(:username => 'API USERNAME', :api_key => 'API KEY'

Or: *shorthand*

    dns = CloudDns.new(:username => 'foo', :api_key => 'bar')

Get all domains under the account:

    dns.domains.each do |d|
      d.id            # ID
      d.name          # Name
      d.created       # Creation timestamp
      d.updated       # Modification timestamp
      d.ttl           # Domain TTL
      d.nameservers   # Array of nameservers
      d.record_list   # Hash containing all the records and stats
    end

Get a single domain:

    dns.domain(ID)

## TODO

More features are coming

## License

Copyright &copy; 2011 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.