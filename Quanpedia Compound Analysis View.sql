-- Create the CmpndAnalysis view to aggregate analysis data with compound and ion details
CREATE VIEW CmpndAnalysis AS
    SELECT 
        CmpndAnalysis.Analysis AS Analysis,  -- Name of the analysis
        CmpndAnalysis.Compound AS Name,      -- Name of the compound
        CmpndAnalysis.Formula AS Formula,    -- Formula of the compound
        IonMode.Name AS IonMode,             -- Ionization mode name
        ParentMass,                          -- Parent mass from MRM acquisition details
        ProductMass,                         -- Product mass from MRM acquisition details
        CV,                                  -- Collision voltage (CV) from MRM acquisition details
        CE                                   -- Collision energy (CE) from MRM acquisition details
    FROM 
        MRMIonDetailsView,  -- View containing MRM ion details
        IonMode,            -- Table containing ion mode details
        (
            -- Subquery to select analysis name, compound name, formula, and compound ID
            SELECT 
                Analysis.Name AS Analysis,
                Compound.Name AS Compound,
                Compound.Formula AS Formula,
                Compound.CompoundID
            FROM 
                Compound
                INNER JOIN IonDetails ON Compound.CompoundID = IonDetails.CompoundID
                INNER JOIN Analysis
                    INNER JOIN CompoundsInAnalysis ON Analysis.AnalysisID = CompoundsInAnalysis.AnalysisID
                    ON IonDetails.IonDetailsID = CompoundsInAnalysis.IonDetailsID
        ) AS CmpndAnalysis
    WHERE 
        MRMIonDetailsView.CompoundID = CmpndAnalysis.CompoundID AND 
        IonMode.IonModeID = MRMIonDetailsView.IonModeID;
