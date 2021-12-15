"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAdventOfCode2021Tests,
	#superclass : #PackageManifest,
	#category : #'AdventOfCode2021-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestAdventOfCode2021Tests class >> ruleClassNotReferencedRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'AdventOfCode2021-Tests')) #'2021-12-01T22:22:34.024973-05:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode2021Tests class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'AdventOfCode2021-Tests')) #'2021-12-14T23:10:05.635259-05:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode2021Tests class >> ruleSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#AdventOfCode2021Test)) #'2021-12-01T22:29:53.437863-05:00') )
]
