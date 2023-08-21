FROM ncbi/sra-tools:latest

RUN apk add --no-cache bash
RUN bash 
RUN prefetch --version 

# docker tag local-image:tagname new-repo:tagname
# docker push new-repo:tagname