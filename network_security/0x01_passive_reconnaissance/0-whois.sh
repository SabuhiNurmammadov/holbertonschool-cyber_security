#!/bin/bash
#!/bin/bash

domain="$1"

whois "$domain" | awk '
/Registrant Contact/ {c="Registrant"}
/Administrative Contact/ {c="Admin"}
/Technical Contact/ {c="Tech"}

c && /Name:/              {print c" Name,"$2}
c && /Organization:/      {print c" Organization,"$2}
c && /Street:/            {sub("Street: ",""); print c" Street,"$0" "}
c && /City:/              {print c" City,"$2}
c && /State\/Province:/   {print c" State/Province,"$2}
c && /Postal Code:/       {print c" Postal Code,"$3}
c && /Country:/           {print c" Country,"$2}
c && /Phone:/             {print c" Phone,"$2}
c && /Fax:/               {print c" Fax,"$2}
c && /Email:/             {print c" Email,"$2}

END{
 print "Registrant Phone Ext:,"
 print "Registrant Fax Ext:,"
 print "Admin Phone Ext:,"
 print "Admin Fax Ext:,"
 print "Tech Phone Ext:,"
 print "Tech Fax Ext:,"
}' > "$domain.csv"
