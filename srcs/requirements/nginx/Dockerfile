# construit le container depuis cette version de debian
FROM debian:bullseye

# installe nginx && opensll
RUN apt-get update && apt-get install -y \
    nginx openssl && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/nginx/ssl 

# copie le fichier conf dans le container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# copie le script et le rend executable
COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

# ouvre le port 443
EXPOSE 443

CMD ["/init.sh"]