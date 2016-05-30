FROM nginx

MAINTAINER Salvador Gonzalez <sgonzalez@opencanarias.es>

# Set timezone
RUN echo "Atlantic/Canary" > /etc/timezone \  
 && dpkg-reconfigure -f noninteractive tzdata

# Install wget and install/updates certificates
RUN apt-get update \  
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Add main NGINX config
COPY nginx.conf /etc/nginx/

# Add DH params (generated with openssl dhparam -out dhparams.pem 2048)
#COPY ssl/dhparams.pem /etc/ssl/private/

# Add www certificates
#COPY ssl/ssl-ca-certs-startssl.pem /etc/ssl/certs/  
#COPY ssl/ssl-cert-chain-www-example-com.pem /etc/ssl/certs/  
#COPY ssl/ssl-cert-www-example-com.crt /etc/ssl/private/  
#COPY ssl/ssl-cert-www-example-com.key /etc/ssl/private/

# Add virtual hosts
COPY vhosts/ /etc/nginx/conf.d/

# Add static content
COPY html/ /usr/share/nginx/html/ 
