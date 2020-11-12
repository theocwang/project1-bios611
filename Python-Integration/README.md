# Python Integeration Assigment
## IMPORTANT!!!
This particular notebook uses the package "geopandas" among others; part of this library installation process includes installing "fiona". 
I personally ran into an issue with importing "geopandas" because of conflicting dependencies from different Anaconda channels. Here is the
bash code that I used to address that issue in case you run into it:
  
```
conda install fiona pyproj six
pip install geopandas
conda upgrade --all
```

The last command may take a while depending on how many other Anaconda packages you have; you can choose to only upgrade/update geopandas.
Hopefully this resolves any issue that may come up in running this.
