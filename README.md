<h1>How to use</h1>
Run the script by giving it an argument of the file prefix name and module name you want in camel case. The capitalization of the first letter of the module name is optional. For example, the follow two commands will both create the same thing:
```
$ ./viper-template.sh RQ myModuleName
$ ./viper-template.sh RQ MyModuleName
```
This will create a folder named:
```
/MyModuleName
```
The `MyModuleName` directory contains the actual VIPER temnplate files with each file prefixed with the prefix specified. Here all files would be prefixed with RQ.
