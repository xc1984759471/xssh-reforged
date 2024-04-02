FROM devisty/xssh:v2 
EXPOSE 80
LABEL org.label-schema.tc.enabled="1"
LABEL org.label-schema.tc.rate="1mbps"
LABEL org.label-schema.tc.ceil="2mbps"

#ENTRYPOINT ["/sbin/init"]

COPY . /app
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
