class DiseaseData {
  static final Map<String, List<Map<String, String>>> diseases = {
    'Chest & Lungs': [
      {
        "name": "Pneumonia",
        "description":
            "A lung infection that causes inflammation in the air sacs, leading to fluid or pus accumulation. It can be caused by bacteria, viruses, or fungi, and symptoms include fever, cough with phlegm, chest pain, and difficulty breathing.",
        "treatment":
            "\n1- Antibiotics for bacterial pneumonia. \n2- Antiviral medication for viral pneumonia. \n3- Oxygen therapy in severe cases. \n4- Rest, hydration, and fever-reducing medications.",
        "deaths": "2.5M+",
        "recovered": "Varies",
        "infections": "450M+"
      },
      {
        "name": "Chronic Obstructive Pulmonary Disease (COPD)",
        "description":
            "A progressive lung disease that obstructs airflow, making breathing difficult. It includes emphysema and chronic bronchitis, with symptoms such as chronic cough, shortness of breath, and wheezing.",
        "treatment":
            "\n1- Bronchodilators to relax airway muscles. \n2- Corticosteroids to reduce inflammation. \n3- Oxygen therapy for severe cases. \n4- Pulmonary rehabilitation including breathing exercises.",
        "deaths": "3.2M+",
        "recovered": "N/A",
        "infections": "250M+"
      },
      {
        "name": "Asthma",
        "description":
            "A chronic condition causing inflammation and narrowing of the airways, leading to wheezing, shortness of breath, chest tightness, and coughing, especially at night or early morning.",
        "treatment":
            "\n1- Inhaled bronchodilators to open airways. \n2- Corticosteroids to reduce airway inflammation. \n3- Leukotriene modifiers to prevent asthma attacks. \n4- Emergency inhalers for acute flare-ups.",
        "deaths": "450K+",
        "recovered": "Manageable",
        "infections": "262M+"
      },
      {
        "name": "Tuberculosis (TB)",
        "description":
            "A bacterial infection that primarily affects the lungs, causing persistent cough, night sweats, weight loss, fever, and fatigue. TB spreads through airborne droplets when an infected person coughs or sneezes.",
        "treatment":
            "\n1- Long-term antibiotic therapy (usually 6–9 months). \n2- Combination of multiple drugs to prevent resistance. \n3- Directly Observed Therapy (DOT) for adherence. \n4- Isolation of infectious patients in early stages.",
        "deaths": "1.5M+",
        "recovered": "Possible",
        "infections": "10M+ (annually)"
      },
      {
        "name": "Lung Cancer",
        "description":
            "A type of cancer that begins in the lungs, often caused by smoking or prolonged exposure to harmful chemicals. Symptoms include persistent cough, chest pain, weight loss, and coughing up blood.",
        "treatment":
            "\n1- Surgery to remove cancerous lung tissue. \n2- Chemotherapy to kill cancer cells. \n3- Radiation therapy to shrink tumors. \n4- Targeted drug therapy for specific cancer types.",
        "deaths": "1.8M+",
        "recovered": "Varies",
        "infections": "2.2M+ (new cases yearly)"
      },
      {
        "name": "Pulmonary Embolism",
        "description":
            "A blockage in the pulmonary arteries, usually due to a blood clot traveling from the legs. This condition can be life-threatening, causing sudden shortness of breath, chest pain, and rapid heart rate.",
        "treatment":
            "\n1- Anticoagulants to prevent clot growth. \n2- Thrombolytic drugs to dissolve clots. \n3- Oxygen therapy for breathing support. \n4- Surgical removal of large clots in severe cases.",
        "deaths": "100K+",
        "recovered": "High",
        "infections": "900K+ (annually)"
      },
      {
        "name": "Pulmonary Fibrosis",
        "description":
            "A condition where lung tissue becomes scarred and stiff, making breathing difficult. Symptoms include dry cough, fatigue, shortness of breath, and clubbing of the fingers.",
        "treatment":
            "\n1- Antifibrotic medications to slow disease progression. \n2- Oxygen therapy to improve breathing. \n3- Pulmonary rehabilitation for symptom management. \n4- Lung transplant in advanced cases.",
        "deaths": "Rare",
        "recovered": "N/A",
        "infections": "4M+"
      },
      {
        "name": "Bronchitis",
        "description":
            "Inflammation of the bronchial tubes, leading to excessive mucus production, persistent cough, chest discomfort, and mild fever. It can be acute or chronic.",
        "treatment":
            "\n1- Cough suppressants for symptom relief. \n2- Bronchodilators to ease breathing. \n3- Increased fluid intake to thin mucus. \n4- Rest and supportive care for recovery.",
        "deaths": "Rare",
        "recovered": "High",
        "infections": "5M+ (annually)"
      },
      {
        "name": "Emphysema",
        "description":
            "A type of COPD where the air sacs in the lungs become damaged, reducing oxygen exchange. Symptoms include chronic breathlessness, persistent cough, and fatigue.",
        "treatment":
            "\n1- Bronchodilators to relax airways. \n2- Corticosteroids to reduce inflammation. \n3- Pulmonary rehabilitation for better lung function. \n4- Oxygen therapy for advanced cases.",
        "deaths": "Rare",
        "recovered": "N/A",
        "infections": "11M+"
      },
      {
        "name": "Pleural Effusion",
        "description":
            "Excess fluid buildup between the lungs and chest cavity, causing breathing difficulties, chest pain, and persistent coughing. It is often associated with infections, heart failure, or lung diseases.",
        "treatment":
            "\n1- Thoracentesis to drain excess fluid. \n2- Diuretics for fluid management. \n3- Antibiotics for infection-related effusions. \n4- Surgery in severe or recurrent cases.",
        "deaths": "Rare",
        "recovered": "N/A",
        "infections": "4M+"
      }
    ],
    'Gastrointestinal Diseases': [
      {
        'name': 'Gastroesophageal Reflux Disease (GERD)',
        'description':
            'A chronic digestive disorder where stomach acid frequently flows back into the esophagus.',
        'treatment':
            'Lifestyle changes, antacids, proton pump inhibitors, and surgery if needed.',
        'deaths': 'Rare',
        'recovered': 'Managed with treatment',
        'infections': 'Millions+'
      },
      {
        'name': 'Irritable Bowel Syndrome (IBS)',
        'description':
            'A common disorder affecting the large intestine, causing abdominal pain, bloating, and changes in bowel habits.',
        'treatment':
            'Dietary changes, stress management, fiber supplements, and medications.',
        'deaths': 'Rare',
        'recovered': 'Managed with treatment',
        'infections': 'Millions+'
      },
      {
        'name': 'Peptic Ulcer Disease',
        'description':
            'Sores that develop in the lining of the stomach or small intestine, often caused by infection with H. pylori or long-term NSAID use.',
        'treatment': 'Antibiotics, proton pump inhibitors, lifestyle changes.',
        'deaths': 'Few',
        'recovered': 'Curable with treatment',
        'infections': 'Millions+'
      },
      {
        'name': 'Crohn’s Disease',
        'description':
            'A chronic inflammatory bowel disease affecting the digestive tract, leading to pain, severe diarrhea, fatigue, and malnutrition.',
        'treatment':
            'Anti-inflammatory medications, immunosuppressants, biologic therapies, and surgery.',
        'deaths': 'Rare',
        'recovered': 'Managed with treatment',
        'infections': 'Millions+'
      },
      {
        'name': 'Celiac Disease',
        'description':
            'An immune reaction to gluten that damages the small intestine lining, leading to nutrient malabsorption.',
        'treatment': 'Gluten-free diet and vitamin supplementation.',
        'deaths': 'Rare',
        'recovered': 'Managed with treatment',
        'infections': 'Millions+'
      }
    ],
    'Cardiovascular Diseases': [
      {
        'name': 'Hypertension (High Blood Pressure)',
        'description':
            'A condition in which the force of the blood against the artery walls is too high, increasing the risk of heart disease and stroke.',
        'treatment':
            'Lifestyle changes, antihypertensive medications, diuretics, and reducing salt intake.',
        'deaths': '10M+',
        'recovered': 'Managed with treatment',
        'infections': '1.28B+'
      },
      {
        'name': 'Coronary Artery Disease (CAD)',
        'description':
            'A condition where the major blood vessels supplying the heart become narrowed or blocked, often leading to heart attacks.',
        'treatment':
            'Medications, lifestyle changes, angioplasty, and bypass surgery.',
        'deaths': '7M+',
        'recovered': 'Varies depending on severity',
        'infections': 'Millions+'
      },
      {
        'name': 'Heart Attack (Myocardial Infarction)',
        'description':
            'Occurs when a blockage in the coronary arteries reduces or stops blood flow to the heart muscle, causing tissue damage.',
        'treatment':
            'Emergency medical intervention, clot-busting drugs, angioplasty, and lifestyle changes.',
        'deaths': '3M+',
        'recovered': 'Depends on medical intervention',
        'infections': 'Millions per year'
      },
      {
        'name': 'Stroke',
        'description':
            'A condition where the blood supply to part of the brain is interrupted or reduced, preventing brain tissue from getting oxygen and nutrients.',
        'treatment':
            'Clot-dissolving drugs, mechanical thrombectomy, rehabilitation, and lifestyle changes.',
        'deaths': '6M+',
        'recovered': 'Depends on severity and treatment',
        'infections': 'Millions per year'
      },
      {
        'name': 'Arrhythmia',
        'description':
            'Irregular heartbeats that can be too fast, too slow, or erratic, affecting blood circulation and leading to complications.',
        'treatment':
            'Medications, pacemakers, catheter ablation, and lifestyle modifications.',
        'deaths': 'Varies',
        'recovered': 'Managed with treatment',
        'infections': 'Common worldwide'
      },
      {
        'name': 'Heart Failure',
        'description':
            'A chronic condition where the heart is unable to pump blood efficiently, leading to fatigue, shortness of breath, and fluid retention.',
        'treatment':
            'Medications, lifestyle changes, and in severe cases, heart transplant.',
        'deaths': '9M+',
        'recovered': 'Managed with treatment',
        'infections': 'Millions+'
      },
      {
        'name': 'Aortic Aneurysm',
        'description':
            'An abnormal bulge in the wall of the aorta, which can rupture and cause life-threatening bleeding.',
        'treatment':
            'Monitoring, medications to lower blood pressure, and surgery if necessary.',
        'deaths': '150K+',
        'recovered': 'Depends on early detection',
        'infections': 'N/A'
      },
      {
        'name': 'Peripheral Artery Disease (PAD)',
        'description':
            'A condition where narrowed arteries reduce blood flow to the limbs, leading to pain and complications.',
        'treatment':
            'Lifestyle changes, medications, angioplasty, and surgery.',
        'deaths': '200K+',
        'recovered': 'Managed with treatment',
        'infections': '200M+'
      },
      {
        'name': 'Cardiomyopathy',
        'description':
            'A disease of the heart muscle that makes it harder for the heart to pump blood effectively.',
        'treatment':
            'Medications, implanted devices, and in severe cases, heart transplant.',
        'deaths': 'Varies',
        'recovered': 'Managed with treatment',
        'infections': 'Common worldwide'
      },
      {
        'name': 'Endocarditis',
        'description':
            'An infection of the heart’s inner lining, usually caused by bacteria entering the bloodstream.',
        'treatment':
            'Antibiotics and, in severe cases, surgery to repair heart valves.',
        'deaths': 'Rare',
        'recovered': 'Curable with early treatment',
        'infections': '50K+ cases per year'
      }
    ],
    'Bones & Muscles': [
      {
        'name': 'Osteoporosis',
        'description': 'Weakening of bones, making them fragile.',
        'treatment': 'Calcium, Vitamin D, weight-bearing exercises.',
        'deaths': '8,000',
        'recovered': 'N/A',
        'infections': '200M+',
      },
      {
        'name': 'Rheumatoid Arthritis',
        'description': 'Autoimmune disease causing joint inflammation.',
        'treatment': 'Anti-inflammatory drugs, immunosuppressants.',
        'deaths': '25,000',
        'recovered': 'N/A',
        'infections': '18M+',
      },
      {
        'name': 'Osteoarthritis',
        'description': 'Degeneration of joint cartilage.',
        'treatment': 'Pain relievers, physiotherapy.',
        'deaths': 'Rare',
        'recovered': 'N/A',
        'infections': '500M+',
      },
      {
        'name': 'Gout',
        'description': 'Form of arthritis caused by uric acid buildup.',
        'treatment': 'Diet change, anti-inflammatory drugs.',
        'deaths': 'Rare',
        'recovered': 'Manageable',
        'infections': '9M+',
      },
      {
        'name': 'Fibromyalgia',
        'description': 'Widespread musculoskeletal pain.',
        'treatment': 'Pain relievers, stress management.',
        'deaths': 'Rare',
        'recovered': 'N/A',
        'infections': '4M+',
      },
      {
        'name': 'Scoliosis',
        'description': 'Abnormal curvature of the spine.',
        'treatment': 'Bracing, surgery.',
        'deaths': 'Rare',
        'recovered': 'Possible',
        'infections': '7M+',
      },
      {
        'name': 'Tendinitis',
        'description': 'Inflammation of tendons.',
        'treatment': 'Rest, ice, anti-inflammatory drugs.',
        'deaths': 'Rare',
        'recovered': 'High',
        'infections': '10M+',
      },
      {
        'name': 'Muscular Dystrophy',
        'description': 'Genetic disorder causing muscle weakness.',
        'treatment': 'Physical therapy, medications.',
        'deaths': 'Rare',
        'recovered': 'N/A',
        'infections': '250K+',
      },
      {
        'name': 'Osgood-Schlatter Disease',
        'description': 'Knee pain in growing children.',
        'treatment': 'Rest, ice, physiotherapy.',
        'deaths': 'Rare',
        'recovered': 'High',
        'infections': '5M+',
      },
      {
        'name': 'Bone Fractures',
        'description': 'Breaks in bones due to injury.',
        'treatment': 'Casting, surgery if severe.',
        'deaths': 'Varies',
        'recovered': 'High',
        'infections': 'Millions+',
      },
      {
        'name': 'Herniated Disc',
        'description': 'Displacement of spinal discs.',
        'treatment': 'Physical therapy, surgery.',
        'deaths': 'Rare',
        'recovered': 'High',
        'infections': '10M+',
      },
      {
        'name': 'Bursitis',
        'description': 'Inflammation of the bursae.',
        'treatment': 'Rest, pain relievers.',
        'deaths': 'Rare',
        'recovered': 'High',
        'infections': '8M+'
      },
      {
        'name': 'Paget’s Disease',
        'description': 'Abnormal bone destruction and regrowth.',
        'treatment': 'Medications, surgery.',
        'deaths': 'Rare',
        'recovered': 'Manageable',
        'infections': '5M+',
      },
      {
        'name': 'Carpal Tunnel Syndrome',
        'description': 'Compression of the median nerve in the wrist.',
        'treatment': 'Wrist splints, surgery.',
        'deaths': 'Rare',
        'recovered': 'High',
        'infections': '6M+',
      },
      {
        'name': 'Achilles Tendonitis',
        'description': 'Inflammation of the Achilles tendon.',
        'treatment': 'Rest, ice, stretching.',
        'deaths': 'Rare',
        'recovered': 'High',
        'infections': '3M+',
      },
    ],
  };
}
