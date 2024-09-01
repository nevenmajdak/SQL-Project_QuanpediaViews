/* View created for customers report*/

CREATE VIEW CmpndAnalysis AS
    SELECT Analysis.Name AS Analysis,
           Compound.Name AS Compound,
           Compound.Formula AS Formula,
           Compound.CompoundID
      FROM (
               Compound
               INNER JOIN
               IonDetails ON Compound.CompoundID = IonDetails.CompoundID
           )
           INNER JOIN
           (
               Analysis
               INNER JOIN
               CompoundsInAnalysis ON Analysis.AnalysisID = CompoundsInAnalysis.AnalysisID
           )
           ON IonDetails.IonDetailsID = CompoundsInAnalysis.IonDetailsID;
