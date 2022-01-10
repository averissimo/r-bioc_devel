ARG TAG=latest

FROM bioconductor/bioconductor_docker:${TAG}

# Install system packages
RUN apt-get update --quiet \
   && apt-get install curl -y --quiet \
   && apt-get autoremove -y --quiet \
   && apt-get clean --quiet \
   && apt-get install -y --no-install-recommends apt-utils \
   && apt-get install -y --no-install-recommends \
    qpdf \
    texlive \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    texlive-science \
    texi2html \
    texinfo \
  && rm -rf /var/lib/apt/lists/*

# Install R base packages
RUN Rscript -e "install.packages(c('remotes', 'BiocManager', 'rcmdcheck', 'devtools'))" \
  && Rscript -e "BiocManager::install('BiocCheck')"

# Install system dependencies for package glmSparseNet
RUN curl 'https://codeload.github.com/sysbiomed/glmSparseNet/zip/refs/heads/master' -o master.zip \
  && unzip master.zip \
  && cd glmSparseNet-master \
  && apt-get update --quiet \
  && Rscript -e 'writeLines(remotes::system_requirements("ubuntu", "20.04"))' | xargs -I {} bash -c "{} --quiet" \
  && rm -rf /var/lib/apt/lists/* \
  && cd .. \
  && rm -rf glmSparseNet-master

// RUN touch /entrypoint.R

// WORKDIR /home/rstudio

CMD ["/init"]

// ENTRYPOINT sudo -u rstudio -H Rscript /entrypoint.R
