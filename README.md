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
    rake install

## Usage

**Create a CloudDns client**

```ruby
dns = CloudDns::Client.new(:username => 'API USERNAME', :api_key => 'API KEY')

# or via shortcut
dns = CloudDns.new(:username => 'foo', :api_key => 'bar')
```

**Get a list of all existing domains**

```ruby
# Get list of 10 domains
domains = dns.domains

# Get 50 domains with offset
domains = dns.domains(:limit => 50, :offet => 10)

# Search domains by name
domains = dns.domains(:name => 'foo.com')        
```

**Get a list of all domain records**

```ruby
domain = dns.domain(12345)

# returns all records
records = domain.records

# get only specific type of records
# types are: A, AAAA, CNAME, MX, NS, TXT, SRV
records = domain.find_records('A')

# or find records via shortcut
records = domain.mx_records

# find specific record
record = domain.record('A-12345')
```

**Domain manipulation**

```ruby
domain = dns.domain(12345)

domain.name = 'new.foo.com'

# saves domain information
domain.save 

# deletes the domain
domain.delete

# create a new domain
domain = dns.create_domain('foo.com', :email => 'your@email.com')

# returns true if domain is new
domain.new?
```

**Domain records manupulation**

```ruby
domain = dns.domain(12345)

# Add a new record
domain.add_record(:type => 'A', :name => 'foo.com', :data => '127.0.0.1', :ttl => 3600)

# Or add via shortcut:
domain.a(:name => 'foo.com', :data => '127.0.0.1')
domain.cname(:name => 'www.foo.com', :data => 'foo.com')
domain.ns(:name => 'ns.rackspace.com', :data => 'ns.rackspace.com')
domain.mx(:name => 'mail.foo.com', :data => 'mail.google.com', :priority => 10)

# Edit an existing record:

record = domain.a_records.first
record.data = 'NEW_IP_ADDRESS'
record.save     # save this records directly

# Delete the record
record.delete 

# Save domain (all new records will be created and all changed will be updated)
domain.save
```

**Useful record methods**

```ruby
# returns true if this record does not exist
record.new?    

# returns true if record data was changed
record.changed? 

# shortcuts to check if record is a specific one
record.a?
record.aaaa? # ipv6
record.mx?
record.cname?
record.txt?
record.ns?
record.srv?
```

## License

Copyright &copy; 2011 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.