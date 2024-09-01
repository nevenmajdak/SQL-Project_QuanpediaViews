/* View created for customers report*/

CREATE VIEW CmpNameParProd AS
    SELECT CmpndAnalysis.Analysis AS Analysis,
           CmpndAnalysis.Compound AS Name,
           CmpndAnalysis.Formula AS Formula,
           IonMode.Name AS IonMode,
           ParentMass,
           ProductMass,
           CV,
           CE
      FROM MRMIonDetailsView,
           IonMode,
           CmpndAnalysis
     WHERE MRMIonDetailsView.CompoundID = CmpndAnalysis.CompoundID AND 
           IonMode.IonModeID = MRMIonDetailsView.IonModeID;
