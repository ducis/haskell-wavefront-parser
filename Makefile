RUNGHC=runghc -f ghc-7.4.2
t:
	$(RUNGHC) parseWavefront.hs < ../m/gourd.obj |tee gourd.mraw| $(RUNGHC) printWavefront.hs >gourd_.obj
	$(RUNGHC) parseWavefront.hs < ../m/roi.obj |tee roi.mraw| $(RUNGHC) printWavefront.hs >roi_.obj
chk:
	$(RUNGHC) parseWavefront.hs <gourd_.obj >gourd_.mraw
	diff gourd_.mraw gourd.mraw
