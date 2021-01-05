# TODO [jerben] adjust
FROM ocaml/opam2:4.11 as builder
WORKDIR app
COPY recruitment.opam .
COPY dune-project .
COPY scripts/start.sh .
COPY app app
COPY http http
COPY run run
COPY service service
COPY database database
COPY Makefile .
COPY static static

RUN  sudo apt-get update -y && \
  sudo apt-get install -y libmariadb-dev && \
  opam remote remove --all default && \
  opam remote add default https://opam.ocaml.org && \
  # Pins
  opam pin add -yn recruitment . && \
  # install project dependancies
  OPAMSOLVERTIMEOUT=180 opam depext -y recruitment && \
  opam install --deps-only -y recruitment && \
  sudo chown -R opam:nogroup . && \
  opam config exec -- make

FROM debian:10
WORKDIR /app

COPY --from=builder /home/opam/opam-repository/app/_build/default/run/run.exe run.exe
COPY --from=builder /home/opam/opam-repository/app/static static/
COPY --from=builder /home/opam/opam-repository/app/start.sh start.sh
RUN mkdir logs
RUN chmod +x start.sh

RUN apt-get update -y && apt-get install -qq -yy sudo && \
  sudo apt-get update -y && \
  sudo apt-get install -qq -yy \
    emacs-nox \
    libffi-dev \
    libgmp-dev \
    libpcre3-dev \
    libssl-dev \
    m4 \
    perl \
    pkg-config \
    zlib1g-dev \
    libmariadb-dev \
    xvfb \
    libfontconfig \
    wkhtmltopdf \
    default-jre \
    pdftk-java \
    zip \
    libqt5gui5 \
    libev-dev

# WTF: https://github.com/mirage/ocaml-cohttp/issues/675
RUN sudo bash -c 'echo "http		80/tcp	www		# WorldWideWeb HTTP" >> /etc/services'
RUN sudo bash -c 'echo "https		443/tcp	www		# WorldWideWeb HTTPS" >> /etc/services'

ENV SIHL_ENV production
CMD ["/app/start.sh"]
