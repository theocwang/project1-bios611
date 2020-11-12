# Python Integeration Assigment
## IMPORTANT!!!
This particular notebook uses the package "geopandas" among others; part of this library installation process includes installing "fiona". 
I personally ran into an issue with importing "geopandas" because of conflicting dependencies from different Anaconda channels. 
Here is the error message from my Python notebook:

```
ImportError: dlopen(/Applications/anaconda3/lib/python3.6/site-packages/fiona/ogrext.cpython-36m-darwin.so, 2): Library not loaded: @rpath/libpoppler.71.dylib
  Referenced from: /Applications/anaconda3/lib/libgdal.20.dylib
  Reason: image not found
```

Here is the bash code that I used to address that issue in case you run into it:
  
```
conda install fiona pyproj six
pip install geopandas
```

## Data
You can find the spatial data set of the counties and state borders of North Carolina here: 
https://hub.arcgis.com/datasets/34acbf4a26784f189c9528c1cf317193_0/data
