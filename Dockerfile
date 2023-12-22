FROM maven:3.5-jdk-8 as builder 

WORKDIR /sekiro

COPY . /sekiro 

RUN mvn -Dmaven.test.skip=true package appassembler:assemble \
    && chmod +x target/sekiro-open-demo/bin/sekiro.sh


FROM maven:3.5-jdk-8

WORKDIR /sekiro

COPY --from=builder /sekiro/target/* /sekiro

EXPOSE 5612

CMD [ "/bin/bash",  "/sekiro/bin/sekiro.sh"]