# neRtools
Assorted R functions to aid extraction of named entities using the Apache OpenNLP maximum entropy modelling framework.

## Description
This package provides some R functions that are designed to make named entity identification/extraction using the Apache OpenNLP library a bit easier within R. As such, this package extends the existing functionality offered by Kurt Hornik's openNLP package that is available on CRAN.

neRtools contains three principle functions that make the openNLP package easier to use within R:
* `extract_entities()`: Given a text input, outputs a list of named entities identified in that text.
* `entities_in_common()`: Given a pair of text inputs, finds a set of named entities that are common to both inputs.
* `contains_entities()`: Determines whether a text input contains any entities of a pre-specified type, and reports those entities.

## Installing
This package requires Kurt Hornik's openNLP and NLP packages (available on CRAN), as well as a set of pre-trained maximum entropy models. Sample models are available from: http://datacube.wu.ac.at/.

To install this package directly from github, use the `install_github()` function within the `devtools` package (available on CRAN):
```
install_github('neRtools','tcspears')
```

## Examples
Using `extract_entities` to extract individual sentences, words, parts of speech, and persons from a text input:

```
models <- load_nlp_models(c("sentence","word","POS","person"))

input1 <- "Britain's economy slowed sharply in the first three months of 2015, a setback for Prime Minister
David Cameron who has staked his campaign for re-election next week on the strength of the recovery. 
Economists said the weakness was likely to be a blip, with the economy still on course for another strong 
year of growth."

> extract_entities(input1,models)
$sentence
[1] "Britain's economy slowed sharply in the first three months of 2015, a setback for Prime Minister David Cameron who has staked his campaign for re-election next week on the strength of the recovery."
[2] "Economists said the weakness was likely to be a blip, with the economy still on course for another strong year of growth."                                                                            

$word
[1] "Britain"     "'s"          "economy"     "slowed"      "sharply"     "in"          "the"         "first"      
[9] "three"       "months"      "of"          "2015"        ","           "a"           "setback"     "for"        
[17] "Prime"       "Minister"    "David"       "Cameron"     "who"         "has"         "staked"      "his"        
[25] "campaign"    "re-election" "next"        "week"        "on"          "strength"    "recovery"    "."          
[33] "Economists"  "said"        "weakness"    "was"         "likely"      "to"          "be"          "blip"       
[41] "with"        "still"       "course"      "another"     "strong"      "year"        "growth"     

$POS
$POS$NNP
[1] "Britain"  "Prime"    "Minister" "David"    "Cameron" 

$POS$POS
[1] "'s"

$POS$NN
[1] "economy"     "setback"     "campaign"    "re-election" "week"        "strength"    "recovery"    "weakness"   
[9] "blip"        "course"      "year"        "growth"     

$POS$VBD
[1] "slowed" "said"   "was"   

$POS$RB
[1] "sharply" "still"  

$POS$IN
[1] "in"   "of"   "for"  "on"   "with"

$POS$DT
[1] "the"     "a"       "another"

$POS$JJ
[1] "first"  "next"   "likely" "strong"

$POS$CD
[1] "three" "2015" 

$POS$NNS
[1] "months"     "Economists"

$POS$`,`
character(0)

$POS$WP
[1] "who"

$POS$VBZ
[1] "has"

$POS$VBN
[1] "staked"

$POS$`PRP$`
character(0)

$POS$.
character(0)

$POS$TO
[1] "to"

$POS$VB
[1] "be"


$person
[1] "David Cameron" "Economists"   

$organization
character(0)

$date
[1] "2015"      "next week"

$location
[1] "Britain"

```

