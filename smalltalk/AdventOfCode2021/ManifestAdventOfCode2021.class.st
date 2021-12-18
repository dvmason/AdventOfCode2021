"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAdventOfCode2021,
	#superclass : #PackageManifest,
	#category : #'AdventOfCode2021-Manifest'
}

{ #category : #'code-critics' }
ManifestAdventOfCode2021 class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AdventOfCode2021 #day14b:repeat: #false)) #'2021-12-17T23:57:47.172238-05:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode2021 class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#AdventOfCode2021)) #'2021-12-10T21:32:46.735314-05:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode2021 class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#AdventOfCode2021)) #'2021-12-10T00:34:37.476445-05:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode2021 class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AdventOfCode2021 #day14b:repeat: #false)) #'2021-12-17T23:57:42.665283-05:00') #(#(#RGMethodDefinition #(#AdventOfCode2021 #day14a: #false)) #'2021-12-17T23:58:01.747861-05:00') )
]
