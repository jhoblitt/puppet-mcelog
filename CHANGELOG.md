
#### [Current]

####
 * [25012a4](../../commit/25012a4) - __(Joshua Hoblitt)__ add basic README info
 * [6c1ed79](../../commit/6c1ed79) - __(Joshua Hoblitt)__ add $config_file_template param to mcelog class
 * [dcd23ea](../../commit/dcd23ea) - __(Joshua Hoblitt)__ add support for EL5

* The EL5 mcelog package does not supply an init script

 * [d582bff](../../commit/d582bff) - __(Joshua Hoblitt)__ restrict module to $::architecture == x86_64
 * [fb18dc3](../../commit/fb18dc3) - __(Joshua Hoblitt)__ implement params class pattern

* restrict module to $::osfamily == redhat

 * [e5e849a](../../commit/e5e849a) - __(Joshua Hoblitt)__ refactor init.pp to follow class autoloading rules

* removed mcelog{install,config,service} classes all declared in the same file (init.pp)

 * [c4b5aad](../../commit/c4b5aad) - __(Joshua Hoblitt)__ add minimal tests of declared resources
 * [edf81a4](../../commit/edf81a4) - __(Joshua Hoblitt)__ update copyright notice to -2014
 * [01568cb](../../commit/01568cb) - __(Joshua Hoblitt)__ add module description
 * [3878276](../../commit/3878276) - __(Joshua Hoblitt)__ update .gitignore
 * [603d33d](../../commit/603d33d) - __(Joshua Hoblitt)__ update travis matrix
 * [20ebdc7](../../commit/20ebdc7) - __(Joshua Hoblitt)__ Merge puppet-module_skel
 * [c8157c7](../../commit/c8157c7) - __(Joshua Hoblitt)__ first commit
