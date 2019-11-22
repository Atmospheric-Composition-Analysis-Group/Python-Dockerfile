FROM conda/miniconda3

RUN conda config --add channels conda-forge

RUN conda install cartopy geopandas matplotlib pandas pyproj xarray xesmf
RUN pip install salem
RUN apt-get update && apt-get install -y git && pip install git+git://github.com/geoschem/gcpy

RUN apt-get install -y git wget zsh \
&&  export ZSH=/usr/share/oh-my-zsh \
&&  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh


RUN echo "#!/usr/bin/env bash" > /usr/bin/start-container.sh \
&&  echo 'if [ $# -gt 0 ]; then exec "$@"; else zsh ; fi' >> /usr/bin/start-container.sh \
&&  chmod +x /usr/bin/start-container.sh
ENTRYPOINT ["start-container.sh"]
