var left=prompt("left","");
var top=prompt("top","");
var right=prompt("right","");
var bottom=prompt("bottom","");
fl.getDocumentDOM().selectAll();
fl.getDocumentDOM().convertToSymbol('movie clip', 'mc', 'top left');
var lib = fl.getDocumentDOM().library;
if (lib.getItemProperty('linkageImportForRS') == true) {
lib.setItemProperty('linkageImportForRS', false);
}
else {
lib.setItemProperty('linkageExportForAS', false);
lib.setItemProperty('linkageExportForRS', false);
}
lib.setItemProperty('scalingGrid',  true);
lib.setItemProperty('scalingGridRect', {left:parseInt(left), top:parseInt(top), right:parseInt(right), bottom:parseInt(bottom)});
//lib.setItemProperty('scalingGridRect', {left:10, top:10, right:120, bottom:120});
fl.getDocumentDOM().library.selectItem('mc');
fl.getDocumentDOM().library.editItem();
fl.getDocumentDOM().breakApart();


fl.getDocumentDOM().setSelectionRect({left:0, top:0, right:parseInt(left), bottom:parseInt(top)}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:0, y:0}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:-200, y:0});

fl.getDocumentDOM().setSelectionRect({left:parseInt(left), top:0, right:parseInt(right), bottom:parseInt(top)}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:parseInt(left)+2, y:2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:0, y:-200});

fl.getDocumentDOM().setSelectionRect({left:parseInt(right), top:0, right:parseInt(right)+1000, bottom:parseInt(top)}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:parseInt(right)+2, y:2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:200, y:0});


fl.getDocumentDOM().setSelectionRect({left:0, top:parseInt(top), right:parseInt(left), bottom:parseInt(bottom)}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:2, y:parseInt(top)+2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:-100, y:0});

fl.getDocumentDOM().setSelectionRect({left:parseInt(left), top:parseInt(top), right:parseInt(right), bottom:parseInt(bottom)}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:parseInt(left)+2, y:parseInt(top)+2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:-100, y:-10});

fl.getDocumentDOM().setSelectionRect({left:parseInt(right), top:parseInt(top), right:parseInt(right)+1000, bottom:parseInt(bottom)}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:parseInt(right)+2, y:parseInt(top)+2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:200, y:0});

fl.getDocumentDOM().setSelectionRect({left:0, top:parseInt(bottom), right:parseInt(left), bottom:parseInt(bottom)+1000}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:2, y:parseInt(bottom)+2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:-200, y:0});

fl.getDocumentDOM().setSelectionRect({left:parseInt(left), top:parseInt(bottom), right:parseInt(right), bottom:parseInt(bottom)+1000}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:parseInt(left)+2, y:parseInt(bottom)+2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:0, y:200});

fl.getDocumentDOM().setSelectionRect({left:parseInt(right), top:parseInt(bottom), right:parseInt(right)+1000, bottom:parseInt(bottom)+1000}, true, true);
fl.getDocumentDOM().group();
//fl.getDocumentDOM().mouseClick({x:parseInt(right)+2, y:parseInt(bottom)+2}, false, true);
//fl.getDocumentDOM().moveSelectionBy({x:200, y:0});








