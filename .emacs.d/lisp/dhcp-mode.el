(define-derived-mode dhcp-mode
  c-mode "DHCP config"
  "Major mode for DHCP configuration files.
\\{dhcp-mode-map}"
  (setq case-fold-search nil))

(defvar dhcpdGroupDecl-keywords                                                                 
  '("group" "shared-network" "subnet" "host" "pool" "failover"                                  
    "class" "subclass" "key" "zone" "logging" "channel" "netmask")                              
  "DHCP group declaration keywords.")                                                           
                                                                                                
(defvar dhcpdParameter-keywords                                                                 
  '("option" "code" "range" "dynamic-bootp" "always-broadcast"                                  
    "always-reply-rfc1048" "authoritative" "boot-unknown-clients"                               
    "ddns-hostname" "ddns-domainname" "ddns-rev-domainname"                                     
    "ddns-updates" "ddns-update-style" "default-lease-time"                                     
    "dynamic-bootp-lease-cutoff" "fixed-address" "dynamic-bootp-lease-length"                   
    "filename" "get-lease-hostnames" "hardware" "lease-file-name"                               
    "local-port" "log-facility" "max-lease-time" "min-lease-time"                               
    "min-secs" "next-server" "omapi-port" "one-lease-per-client"                                
    "pid-file-name" "ping-check" "server-identifier" "server-name"                              
    "site-option-space" "stash-agent-options" "update-optimization"                             
    "update-static-leases" "use-host-decl-names" "use-lease-addr-for-default-route"             
    "vendor-option-space")                                                                      
  "DHCP parameter keywords.")                                                                   
                                                                                                
(defvar dhcpdGroupDecl-keywords-regexp (regexp-opt dhcpdGroupDecl-keywords 'words))             
(defvar dhcpdParameter-keywords-regexp (regexp-opt dhcpdParameter-keywords 'words))             
                                                                                                
                                                                                                
(setq dhcpdGroupDecl-keywords nil)                                                              
(setq dhcpdParameter-keywords nil)                                                              
                                                                                                
                                                                                                
(setq dhcpd-font-lock-keywords                                                                  
      `(                                                                                        
        (,dhcpdParameter-keywords-regexp . font-lock-type-face)                                 
        (,dhcpdGroupDecl-keywords-regexp . font-lock-keyword-face)                              
                                                                                                
))

(setq font-lock-defaults '(dhcpd-font-lock-keywords))
(modify-syntax-entry ?# "< b" dhcp-mode-syntax-table)
(modify-syntax-entry ?\n "> b" dhcp-mode-syntax-table)

