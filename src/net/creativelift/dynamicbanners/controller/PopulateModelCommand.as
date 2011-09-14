package net.creativelift.dynamicbanners.controller {
	import net.creativelift.dynamicbanners.helpers.AOLBrowserCall;

	import flash.external.ExternalInterface;

	import com.senocular.utils.SWFReader;

	import net.creativelift.utils.FlashBug;
//	import com.senocular.utils.SWFReader;
	import com.adobe.net.URI;
	
	import net.creativelift.dynamicbanners.interfaces.IDataService;
	import net.creativelift.dynamicbanners.model.ShellModel;
	import net.creativelift.dynamicbanners.model.vo.CASDataVO;
	import net.creativelift.dynamicbanners.signals.LoadCreative;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * @author DouG Molidor doug@creativelift.net
	 */
	
	public class PopulateModelCommand extends Command 
	{
		[Inject] public var flashVars:Object;
		[Inject] public var loadCreativeSignal:LoadCreative;
		[Inject] public var shellModel:ShellModel;
		[Inject] public var dataService:IDataService;

		override public function execute():void 
		{
			shellModel.campaignId = flashVars.cid;
			shellModel.adServerClickTag = flashVars.clickTag;
			
			shellModel.bannerW = contextView.stage.stageWidth;
			shellModel.bannerH = contextView.stage.stageHeight;
			if ( AOLBrowserCall.browserName == "IE" ) shellModel.IEAdjustedBannerW = Number(ExternalInterface.call("function getRealSWFWidth(){return document.getElementsByName('" + ExternalInterface.objectID + "')[0].width; }")); 

			//alt feed: // "http://data.creativelift.net/cas_dynamic/returndatafeedxml.php?x=cha1010_dynamic_shell.xml&cid="
			shellModel.dataURLPrefix = flashVars.hasOwnProperty( "altFeed" ) ? flashVars.altFeed : "http://connect.charter.com/cas/live-zone.ashx?cid=";
			dataService.getCASData(new URI(shellModel.dataURLPrefix + flashVars.cid));
						
			dataService.casDataParsed.add(onDataParsed);
/*
			var fl:FlashBug = new FlashBug();
			
			var swf:SWFReader = new SWFReader(contextView.loaderInfo.bytes);

			fl.log("swf.compressed: "+swf.compressed);
			fl.log("swf.version: "+swf.version);
			fl.log("swf.fileSize: "+swf.fileSize);
			fl.log("swf.dimensions: "+swf.dimensions);
			fl.log("swf.width: "+swf.width);
			fl.log("swf.height: "+swf.height);
			fl.log("swf.tagCallbackBytesIncludesHeader: "+swf.tagCallbackBytesIncludesHeader);
			fl.log("swf.frameRate: "+swf.frameRate);
			fl.log("swf.totalFrames: "+swf.totalFrames);
			fl.log("swf.asVersion: "+swf.asVersion);
			fl.log("swf.usesNetwork: "+swf.usesNetwork);
			fl.log("swf.backgroundColor: "+swf.backgroundColor);
			fl.log("swf.protectedFromImport: "+swf.protectedFromImport);
			fl.log("swf.debuggerEnabled: "+swf.debuggerEnabled);
			fl.log("swf.metadata: "+swf.metadata);
			fl.log("swf.recursionLimit: "+swf.recursionLimit);
			fl.log("swf.scriptTimeoutLimit: "+swf.scriptTimeoutLimit);
			fl.log("swf.hardwareAcceleration: "+swf.hardwareAcceleration);
			fl.log("swf.tagCallback: "+swf.tagCallback);
			fl.log("swf.parsed: "+swf.parsed);
			fl.log("swf.errorText: "+swf.errorText);
			//fl.log("swf.toString: "+swf.toString);
			//fl.log("swf.parse: "+swf.parse);

			// OUTPUT ...
			//swf.compressed: false
			//swf.version: 10
			//swf.fileSize: 7281
			//swf.dimensions: (x=0, y=0, w=550, h=400)
			//swf.width: 550
			//swf.height: 400
			//swf.tagCallbackBytesIncludesHeader: false
			//swf.frameRate: 30
			//swf.totalFrames: 1
			//swf.asVersion: 3
			//swf.usesNetwork: false
			//swf.backgroundColor: 16777215
			//swf.protectedFromImport: false
			//swf.debuggerEnabled: true
			//swf.metadata: <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
			//  <rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
			//    <xmp:CreatorTool>Adobe Flash CS4 Professional</xmp:CreatorTool>
			//    <xmp:CreateDate>2010-04-13T11:55:21+01:00</xmp:CreateDate>
			//    <xmp:MetadataDate>2010-04-14T15:36:11+01:00</xmp:MetadataDate>
			//    <xmp:ModifyDate>2010-04-14T15:36:11+01:00</xmp:ModifyDate>
			//  </rdf:Description>
			//  <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
			//    <dc:format>application/x-shockwave-flash</dc:format>
			//  </rdf:Description>
			//  <rdf:Description rdf:about="" xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/" xmlns:stRef="http://ns.adobe.com/xap/1.0/sType/ResourceRef#">
			//    <xmpMM:DerivedFrom rdf:parseType="Resource">
			//      <stRef:instanceID>xmp.iid:A46D647BE046DF11A42FA6A489EBD966</stRef:instanceID>
			//      <stRef:documentID>xmp.did:A46D647BE046DF11A42FA6A489EBD966</stRef:documentID>
			//      <stRef:originalDocumentID>xmp.did:A46D647BE046DF11A42FA6A489EBD966</stRef:originalDocumentID>
			//    </xmpMM:DerivedFrom>
			//    <xmpMM:DocumentID>xmp.did:17201428D147DF119956F0DDDFBC1A28</xmpMM:DocumentID>
			//    <xmpMM:InstanceID>xmp.iid:17201428D147DF119956F0DDDFBC1A28</xmpMM:InstanceID>
			//    <xmpMM:OriginalDocumentID>xmp.did:A46D647BE046DF11A42FA6A489EBD966</xmpMM:OriginalDocumentID>
			//  </rdf:Description>
			//</rdf:RDF>
			//swf.recursionLimit: 15
			//swf.scriptTimeoutLimit: 256
			//swf.hardwareAcceleration: 0
			//swf.tagCallback: null
			//swf.parsed: true
			//swf.errorText:
*/			
		}

		
		private function onDataParsed(data:CASDataVO):void
		{
			shellModel.casData = data; 
			loadCreativeSignal.dispatch(data.subShell.templateURL);
		}
	}
}
