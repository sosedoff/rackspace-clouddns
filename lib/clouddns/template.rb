module CloudDns
  module Template
    GOOGLE_MX = [
      [10, 'ASPMX.L.GOOGLE.com'],
      [20, 'ALT1.ASPMX.L.GOOGLE.com'],
      [20, 'ALT2.ASPMX.L.GOOGLE.com'],
      [30, 'ASPMX2.GOOGLEMAIL.com'],
      [30, 'ASPMX3.GOOGLEMAIL.com'],
      [30, 'ASPMX4.GOOGLEMAIL.com'],
      [30, 'ASPMX5.GOOGLEMAIL.com']
    ]
    
    def self.google_mail(domain)
      domain.cname(:name => "mail.#{domain.name}", :data => "ghs.google.com")
      GOOGLE_MX.each do |r|
        domain.mx(:name => domain.name, :data => r.last, :priority => r.first)
      end
    end
  end
end
