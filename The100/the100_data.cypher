// --- FINAL SCRIPT: The 100 - MAX DENSITY MODEL ---

// --- 1. CLEANUP AND INITIAL SETUP ---
// Exécuter cette commande dans le navigateur si vous voulez vider la base avant l'importation:
// MATCH (n) DETACH DELETE n;

// --- 2. CREATE FACTIONS, PLACES, CONCEPTS, SAISONS & VIOLATIONS ---
CREATE (:Faction {name:"Skaikru", origin:"The Ark/Sky People"});
CREATE (:Faction {name:"Trikru", origin:"Grounders"});
CREATE (:Faction {name:"Azgeda", origin:"Grounders"});
CREATE (:Faction {name:"Mount Weather", origin:"Mountain Men"});
CREATE (:Faction {name:"The 100"});
CREATE (:Faction {name:"Wonkru", origin:"Bunker Survivors"});
CREATE (:Faction {name:"Spacekru", origin:"Space Survivors"});
CREATE (:Faction {name:"Eligius IV Prisoners", origin:"Space"});
CREATE (:Faction {name:"The Disciples", origin:"Biténa"});
CREATE (:Faction {name:"Floukru", origin:"Savage Coast/Ocean People"});
CREATE (:Faction {name:"Sankru", origin:"Desert/Sand Nomads"});
CREATE (:Faction {name:"Delfikru", origin:"Woods Clan"});
CREATE (:Faction {name:"Sanctum Leaders", origin:"Sanctum"});

CREATE (:Place {name:"Arkadia"});
CREATE (:Place {name:"Polis"});
CREATE (:Place {name:"Mount Weather"});
CREATE (:Place {name:"Tondc"});
CREATE (:Place {name:"The Second Dawn Bunker"});
CREATE (:Place {name:"Shallow Valley"});
CREATE (:Place {name:"The Lighthouse"});
CREATE (:Place {name:"Ice Nation Capital"}); 
CREATE (:Place {name:"The Ark"});
CREATE (:Place {name:"Eligius IV"});
CREATE (:Place {name:"The Ring"}); 
CREATE (:Place {name:"Sanctum"});
CREATE (:Place {name:"Bardo"});
CREATE (:Place {name:"Etherea"});
CREATE (:Place {name:"Skyring"});

CREATE (:Event {name:"The Dropship Landing", description:"Arrivée des 100 sur Terre"});
CREATE (:Event {name:"Massacre at Mount Weather", description:"Clarke et Bellamy irradient le niveau 5"});
CREATE (:Event {name:"Praimfaya", description:"Vague de radiation nucléaire"});
CREATE (:Event {name:"The Conclave", description:"Combat pour le bunker du Second Dawn"});
CREATE (:Event {name:"Arrival at Sanctum", description:"Arrivée de Eligius IV sur Alpha"});
CREATE (:Event {name:"The Final Test", description:"Test de survie pour l'Humanité"});

CREATE (:Season {number:1, title:"The Ground"});
CREATE (:Season {number:2, title:"The Mountain"});
CREATE (:Season {number:3, title:"The City of Light"});
CREATE (:Season {number:4, title:"Praimfaya"});
CREATE (:Season {number:5, title:"Eden"});
CREATE (:Season {number:6, title:"Sanctum"});
CREATE (:Season {number:7, title:"The Final War"});

CREATE (:Violation {name:"Mass Murder", severity:"Extreme", context:"Genocide"});
CREATE (:Violation {name:"Execution of Prisoner", severity:"High", context:"Unlawful death"});
CREATE (:Violation {name:"Torture (M-Cap)", severity:"Extreme", context:"Medical Experimentation"});
CREATE (:Violation {name:"Treason", severity:"High", context:"Betrayal of one's own people"});
CREATE (:Violation {name:"Illegal Confinement", severity:"Medium"});


// --- 3. CREATE PERSONS
CREATE (:Person {name:"Clarke Griffin", gender:"Female", alive:true, title:"Heada", age:"24"});
CREATE (:Person {name:"Bellamy Blake", gender:"Male", alive:false, title:"Co-Leader", age:"25"});
CREATE (:Person {name:"Octavia Blake", gender:"Female", alive:true, title:"Blodreina", age:"22"});
CREATE (:Person {name:"Raven Reyes", gender:"Female", alive:true, title:"Engineer", age:"25"});
CREATE (:Person {name:"Murphy", gender:"Male", alive:true, title:"Survivalist", age:"24"});
CREATE (:Person {name:"Emori", gender:"Female", alive:true, title:"Nomad/Survivalist", age:"24"});
CREATE (:Person {name:"Monty Green", gender:"Male", alive:false, title:"Botanist/Tech", age:"25"});
CREATE (:Person {name:"Harper McIntyre", gender:"Female", alive:false, title:"Guard/Tech", age:"25"});
CREATE (:Person {name:"Jasper Jordan", gender:"Male", alive:false, title:"Student", age:"18"});
CREATE (:Person {name:"Finn Collins", gender:"Male", alive:false, title:"Scout", age:"18"});
CREATE (:Person {name:"Wells Jaha", gender:"Male", alive:false, title:"Friend of Clarke", age:"18"});
CREATE (:Person {name:"Kyle Wick", gender:"Male", alive:true, title:"Technician", age:"30"});
CREATE (:Person {name:"Miller", gender:"Male", alive:true, title:"Guard/Scout", age:"24"});
CREATE (:Person {name:"Bryan", gender:"Male", alive:false, title:"Guard", age:"25"});
CREATE (:Person {name:"Jackson", gender:"Male", alive:true, title:"Medic", age:"26"});
CREATE (:Person {name:"Zoe Monroe", gender:"Female", alive:false, title:"The 100 Member", age:"17"});
CREATE (:Person {name:"Mel", gender:"Female", alive:false, title:"The 100 Member", age:"17"});
CREATE (:Person {name:"Jacapo Sinclair", gender:"Male", alive:false, title:"Mechanic", age:"50"});
CREATE (:Person {name:"Atlee", gender:"Female", alive:false, title:"The 100 Member", age:"17"});
CREATE (:Person {name:"Eric Jackson", gender:"Male", alive:true, title:"Doctor", age:"40"});
CREATE (:Person {name:"Niylah", gender:"Female", alive:true, title:"Trikru Trader", age:"28"});
CREATE (:Person {name:"Marcus Kane", gender:"Male", alive:false, title:"Chancellor", age:"50"});
CREATE (:Person {name:"Abby Griffin", gender:"Female", alive:false, title:"Chief Medical Officer", age:"45"});
CREATE (:Person {name:"Thelonious Jaha", gender:"Male", alive:false, title:"Former Chancellor", age:"55"});
CREATE (:Person {name:"Jake Griffin", gender:"Male", alive:false, title:"Engineer", age:"45"});
CREATE (:Person {name:"Charles Pike", gender:"Male", alive:false, title:"Chancellor", age:"50"});
CREATE (:Person {name:"Sinctair", gender:"Male", alive:false, title:"Guard Captain", age:"40"});
CREATE (:Person {name:"Diana Sydney", gender:"Female", alive:false, title:"Council Member", age:"50"});
CREATE (:Person {name:"Kassandra", gender:"Female", alive:false, title:"Council Member", age:"50"});
CREATE (:Person {name:"Shumway", gender:"Male", alive:false, title:"Guard", age:"45"});
CREATE (:Person {name:"Lexus", gender:"Female", alive:false, title:"Commander", age:"20"});
CREATE (:Person {name:"Indra", gender:"Female", alive:true, title:"Second", age:"50"});
CREATE (:Person {name:"Lincoln", gender:"Male", alive:false, title:"Grounder/Guard", age:"25"});
CREATE (:Person {name:"Echo", gender:"Female", alive:true, title:"Spy/Warrior", age:"26"});
CREATE (:Person {name:"Roan", gender:"Male", alive:false, title:"King of Azgeda", age:"30"});
CREATE (:Person {name:"Titus", gender:"Male", alive:false, title:"Flamekeeper", age:"60"});
CREATE (:Person {name:"Luna", gender:"Female", alive:false, title:"Natblida", age:"25"});
CREATE (:Person {name:"Anya", gender:"Female", alive:false, title:"Trikru Leader", age:"30"});
CREATE (:Person {name:"Gustus", gender:"Male", alive:false, title:"Guard", age:"40"});
CREATE (:Person {name:"Gaia", gender:"Female", alive:true, title:"Flamekeeper", age:"30"});
CREATE (:Person {name:"Aden", gender:"Male", alive:false, title:"Natblida Child", age:"10"});
CREATE (:Person {name:"Madi", gender:"Female", alive:true, title:"Heda/Nightblood", age:"14"});
CREATE (:Person {name:"Ontari", gender:"Female", alive:false, title:"Fake Commander", age:"20"});
CREATE (:Person {name:"Sheidheda", gender:"Male", alive:false, title:"Dark Commander", age:"Ancient"});
CREATE (:Person {name:"Baylis", gender:"Male", alive:false, title:"Trikru Scout", age:"25"});
CREATE (:Person {name:"Ilian", gender:"Male", alive:false, title:"Grounder", age:"25"});
CREATE (:Person {name:"Dante Wallace", gender:"Male", alive:false, title:"President", age:"65"});
CREATE (:Person {name:"Cage Wallace", gender:"Male", alive:false, title:"Leader", age:"35"});
CREATE (:Person {name:"Dr. Tsing", gender:"Female", alive:false, title:"Scientist", age:"50"});
CREATE (:Person {name:"Maya Vie", gender:"Female", alive:false, title:"Rebel", age:"20"});
CREATE (:Person {name:"Charmaine Diyoza", gender:"Female", alive:false, title:"Ex-Criminal Leader", age:"40"});
CREATE (:Person {name:"McCreary", gender:"Male", alive:false, title:"Criminal", age:"40"});
CREATE (:Person {name:"Shaw", gender:"Male", alive:false, title:"Engineer", age:"35"});
CREATE (:Person {name:"Josephine Lightbourne", gender:"Female", alive:false, title:"Prime", age:"25"});
CREATE (:Person {name:"Russell Lightbourne", gender:"Male", alive:true, title:"Prime", age:"300"});
CREATE (:Person {name:"Simone Lightbourne", gender:"Female", alive:false, title:"Prime", age:"300"});
CREATE (:Person {name:"Gabriel Santiago", gender:"Male", alive:false, title:"Anomaly Expert", age:"300"});
CREATE (:Person {name:"Hope Diyoza", gender:"Female", alive:true, title:"Warrior", age:"20"});
CREATE (:Person {name:"Bill Cadogan", gender:"Male", alive:false, title:"The Shepherd", age:"Ancient"});
CREATE (:Person {name:"Levitt", gender:"Male", alive:true, title:"Disciples Guard", age:"35"});
CREATE (:Person {name:"Nelson", gender:"Male", alive:false, title:"Settler Leader", age:"30"});
CREATE (:Person {name:"Callie Cadogan", gender:"Female", alive:false, title:"Founder of Trikru", age:"18"});
CREATE (:Person {name:"Anders", gender:"Male", alive:false, title:"Disciples Leader", age:"45"});
CREATE (:Person {name:"Bree", gender:"Female", alive:false, title:"Disciples Guard", age:"25"});
CREATE (:Person {name:"Dev", gender:"Male", alive:false, title:"Guard", age:"30"});
CREATE (:Person {name:"Becca Pramheda", gender:"Female", alive:false, title:"First Commander", age:"40"});

// RELATIONS PARENTS/ENFANTS (Parent_Of) & FRÈRE/SŒUR (Sibling_Of) ---

MATCH (p:Person {name:"Abby Griffin"}), (c:Person {name:"Clarke Griffin"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p:Person {name:"Jake Griffin"}), (c:Person {name:"Clarke Griffin"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p:Person {name:"Bellamy Blake"}), (c:Person {name:"Octavia Blake"}) CREATE (p)-[:SIBLING_OF]->(c);
MATCH (p:Person {name:"Russell Lightbourne"}), (c:Person {name:"Josephine Lightbourne"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p:Person {name:"Simone Lightbourne"}), (c:Person {name:"Josephine Lightbourne"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p:Person {name:"Charmaine Diyoza"}), (c:Person {name:"Hope Diyoza"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p:Person {name:"Dante Wallace"}), (c:Person {name:"Cage Wallace"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p:Person {name:"Bill Cadogan"}), (c:Person {name:"Callie Cadogan"}) CREATE (p)-[:PARENT_OF]->(c);
MATCH (p1:Person {name:"Russell Lightbourne"}), (p2:Person {name:"Simone Lightbourne"}) CREATE (p1)-[:MARRIED_TO]->(p2);
MATCH (p1:Person {name:"Octavia Blake"}), (p2:Person {name:"Lincoln"}) CREATE (p1)-[:TRAINED_BY]->(p2);
MATCH (p1:Person {name:"Indra"}), (p2:Person {name:"Octavia Blake"}) CREATE (p2)<-[:MENTORED_BY]-(p1);

// LIENS PARENTS/ENFANTS ET FRATERNELS
MATCH (a:Person {name:"Abby Griffin"}), (j:Person {name:"Jake Griffin"}), (c:Person {name:"Clarke Griffin"}) 
CREATE (a)-[:PARENT_OF]->(c), (j)-[:PARENT_OF]->(c);
MATCH (b:Person {name:"Bellamy Blake"}), (o:Person {name:"Octavia Blake"}) 
CREATE (b)-[:SIBLING_OF]->(o), (o)-[:SIBLING_OF]->(b); // Relation Sibling bidirectionnelle
MATCH (r:Person {name:"Russell Lightbourne"}), (s:Person {name:"Simone Lightbourne"}), (j:Person {name:"Josephine Lightbourne"})
CREATE (r)-[:PARENT_OF]->(j), (s)-[:PARENT_OF]->(j);
MATCH (c:Person {name:"Charmaine Diyoza"}), (h:Person {name:"Hope Diyoza"}) 
CREATE (c)-[:PARENT_OF]->(h);
MATCH (d:Person {name:"Dante Wallace"}), (c:Person {name:"Cage Wallace"}) 
CREATE (d)-[:PARENT_OF]->(c);
MATCH (b:Person {name:"Bill Cadogan"}), (c:Person {name:"Callie Cadogan"}) 
CREATE (b)-[:PARENT_OF]->(c);

// RELATIONS AMOUREUSES (ROMANTIC_RELATION_WITH)

MATCH (p1:Person {name:"Murphy"}), (p2:Person {name:"Emori"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {status:"Long-term/Endgame"}]->(p2);
MATCH (p1:Person {name:"Monty Green"}), (p2:Person {name:"Harper McIntyre"}) 
CREATE (p1)-[:MARRIED_TO {status:"Endgame"}]->(p2);
MATCH (p1:Person {name:"Marcus Kane"}), (p2:Person {name:"Abby Griffin"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {status:"Kabby"}]->(p2);
MATCH (p1:Person {name:"Octavia Blake"}), (p2:Person {name:"Lincoln"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {status:"Inseparable"}]->(p2);
MATCH (p1:Person {name:"Miller"}), (p2:Person {name:"Jackson"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {status:"Stable"}]->(p2);
MATCH (p1:Person {name:"Bellamy Blake"}), (p2:Person {name:"Echo"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {season: "5-7"}]->(p2);
MATCH (p1:Person {name:"Octavia Blake"}), (p2:Person {name:"Levitt"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {season: "7"}]->(p2);
MATCH (p1:Person {name:"Clarke Griffin"}), (p2:Person {name:"Lexus"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {type: "Clexa"}]->(p2);
MATCH (p1:Person {name:"Raven Reyes"}), (p2:Person {name:"Kyle Wick"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {season: 2}]->(p2);
MATCH (p1:Person {name:"Raven Reyes"}), (p2:Person {name:"Shaw"}) 
CREATE (p1)-[:ROMANTIC_RELATION_WITH {season: 5}]->(p2);

// RELATIONS AMITIE

WITH ["Clarke Griffin", "Bellamy Blake", "Octavia Blake", "Raven Reyes", "Murphy", "Miller", "Jackson", "Echo","Monty Green","Jasper Jordan"] AS theCore
UNWIND theCore AS p1Name
UNWIND theCore AS p2Name
WITH p1Name, p2Name WHERE p1Name < p2Name
MATCH (p1:Person {name: p1Name}), (p2:Person {name: p2Name})
CREATE (p1)-[:TRUSTS {type: "Survival Bond"}]->(p2);
WITH ["Clarke Griffin", "Bellamy Blake", "Raven Reyes", "Murphy", "Emori", "Echo"] AS spacekruSurvivors
UNWIND spacekruSurvivors AS p1Name
UNWIND spacekruSurvivors AS p2Name
WITH p1Name, p2Name WHERE p1Name < p2Name
MATCH (p1:Person {name: p1Name}), (p2:Person {name: p2Name})
CREATE (p1)-[:TRUSTS {type: "Spacekru Bond"}]->(p2);
WITH ["Octavia Blake", "Indra", "Miller", "Jackson", "Niylah", "Gaia", "Marcus Kane", "Abby Griffin"] AS wonkruSurvivors
UNWIND wonkruSurvivors AS p1Name
UNWIND wonkruSurvivors AS p2Name
WITH p1Name, p2Name WHERE p1Name < p2Name
MATCH (p1:Person {name: p1Name}), (p2:Person {name: p2Name})
CREATE (p1)-[:TRUSTS {type: "Bunker Allegiance"}]->(p2);

// RELATIONS LIEUX 
MATCH (p:Person), (l:Place {name:"Arkadia"})
WHERE p.name IN ["Marcus Kane", "Abby Griffin", "Charles Pike", "Miller", "Jackson", "Raven Reyes", "Kyle Wick"]
CREATE (p)-[:LIVED_IN]->(l);
MATCH (p:Person), (l:Place {name:"Polis"})
WHERE p.name IN ["Lexus", "Indra", "Roan", "Titus"]
CREATE (p)-[:LIVED_IN]->(l);
MATCH (p:Person), (l:Place {name:"The Second Dawn Bunker"})
WHERE p.name IN ["Octavia Blake", "Indra", "Miller", "Jackson", "Gaia", "Marcus Kane"]
CREATE (p)-[:SURVIVED_IN]->(l);
MATCH (p:Person), (l:Place {name:"Mount Weather"})
WHERE p.name IN ["Jasper Jordan", "Maya Vie", "Dante Wallace", "Cage Wallace"]
CREATE (p)-[:LOCATED_AT]->(l);
MATCH (p:Person), (l:Place {name:"The Ark"})
WHERE p.name IN ["Thelonious Jaha", "Abby Griffin", "Marcus Kane"]
CREATE (p)-[:LIVED_ON]->(l);
MATCH (p:Person), (l:Place {name:"Sanctum"})
WHERE p.name IN ["Russell Lightbourne", "Hope Diyoza", "Gabriel Santiago"]
CREATE (p)-[:LOCATED_AT]->(l);


// RELATIONS Saison

MATCH (p:Person), (s:Season)
WHERE p.name IN ["Clarke Griffin", "Octavia Blake", "Raven Reyes", "Murphy", "Emori", "Miller", "Jackson", "Niylah", "Echo", "Gaia"]
CREATE (p)-[:PRESENT_IN]->(s);
MATCH (p:Person)
WHERE p.name IN ["Marcus Kane", "Abby Griffin", "Thelonious Jaha", "Indra", "Monty Green", "Harper McIntyre", "Gabriel Santiago", "Charmaine Diyoza"]
MATCH (s:Season) WHERE s.number IN [1, 2, 3, 4, 5, 6]
CREATE (p)-[:PRESENT_IN]->(s);
MATCH (p:Person)
WHERE p.name IN ["Lincoln", "Lexus", "Finn Collins", "Jasper Jordan", "Wells Jaha", "Charles Pike", "Roan", "Titus", "Anya", "Gustus"]
MATCH (s:Season) WHERE s.number IN [1, 2, 3, 4]
CREATE (p)-[:PRESENT_IN]->(s);
MATCH (p:Person)
WHERE p.name IN ["Hope Diyoza", "Levitt", "Bill Cadogan", "Russell Lightbourne", "Madi", "Anders", "Nelson", "Simone Lightbourne"]
MATCH (s:Season) WHERE s.number IN [5, 6, 7]
CREATE (p)-[:PRESENT_IN]->(s);
MATCH (p:Person)
WHERE p.name IN ["Dante Wallace", "Cage Wallace", "Dr. Tsing", "Maya Vie"]
MATCH (s:Season) WHERE s.number = 2
CREATE (p)-[:PRESENT_IN]->(s);


// LIEN CRIMES

MATCH (v:Violation {name:"Mass Murder"}), (p:Person {name:"Clarke Griffin"})
CREATE (p)-[:RESPONSIBLE_FOR {context: "Primary Initiator"}]->(v);
MATCH (v:Violation {name:"Mass Murder"}), (p:Person {name:"Bellamy Blake"})
CREATE (p)-[:RESPONSIBLE_FOR {context: "Co-Initiator"}]->(v);
MATCH (v:Violation {name:"Execution of Prisoner"}), (p:Person {name:"Charles Pike"})
CREATE (p)-[:ORDERED_VIOLATION {victim: "Lincoln"}]->(v);
MATCH (v:Violation {name:"Torture (M-Cap)"}), (p:Person {name:"Dr. Tsing"})
CREATE (p)-[:COMMITTED]->(v);
MATCH (v:Violation {name:"Treason"}), (p:Person {name:"Shumway"})
CREATE (p)-[:COMMITTED]->(v);
MATCH (v:Violation {name:"Destruction of Property"}), (p:Person {name:"McCreary"})
CREATE (p)-[:COMMITTED {target: "Shallow Valley"}]->(v);
MATCH (v:Violation {name:"Mass Murder"}), (p:Person {name:"Octavia Blake"})
CREATE (p)-[:RESPONSIBLE_FOR {context: "Dark Year / Cannibalism"}]->(v);



// LIENS AVEC LES FACTIONS
WITH ["Clarke Griffin", "Bellamy Blake", "Octavia Blake", "Raven Reyes", "Murphy", "Emori", "Monty Green", "Harper McIntyre", "Jasper Jordan", "Finn Collins", "Wells Jaha", "Kyle Wick", "Marcus Kane", "Abby Griffin", "Thelonious Jaha", "Jake Griffin", "Charles Pike", "Sinctair", "Miller", "Bryan", "Jackson", "Zoe Monroe", "Mel", "Jacapo Sinclair", "Atlee", "Eric Jackson", "Kassandra", "Shumway", "Niylah", "Becca Pramheda", "Hope Diyoza", "Diana Sydney"] AS skaikruNames
MATCH (f:Faction {name:"Skaikru"})
UNWIND skaikruNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF {status:"Original Sky Person"}]->(f);
WITH ["Clarke Griffin", "Bellamy Blake", "Octavia Blake", "Raven Reyes", "Murphy", "Jasper Jordan", "Finn Collins", "Wells Jaha", "Miller", "Bryan", "Zoe Monroe", "Mel", "Atlee"] AS the100Names
MATCH (f:Faction {name:"The 100"})
UNWIND the100Names AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Lexus", "Indra", "Lincoln", "Anya", "Gustus", "Gaia", "Madi", "Ilian", "Callie Cadogan", "Baylis", "Dev"] AS trikruNames
MATCH (f:Faction {name:"Trikru"})
UNWIND trikruNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Roan", "Echo", "Ontari"] AS azgedaNames
MATCH (f:Faction {name:"Azgeda"})
UNWIND azgedaNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Dante Wallace", "Cage Wallace", "Dr. Tsing", "Maya Vie"] AS mwNames
MATCH (f:Faction {name:"Mount Weather"})
UNWIND mwNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Charmaine Diyoza", "McCreary", "Shaw", "Russell Lightbourne", "Josephine Lightbourne", "Simone Lightbourne", "Gabriel Santiago", "Nelson"] AS eligiusSanctumNames
MATCH (f:Faction {name:"Eligius IV Prisoners"})
UNWIND eligiusSanctumNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Octavia Blake", "Marcus Kane", "Indra", "Miller", "Jackson", "Niylah", "Gaia"] AS wonkruNames
MATCH (f:Faction {name:"Wonkru"})
UNWIND wonkruNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Clarke Griffin", "Bellamy Blake", "Raven Reyes", "Murphy", "Emori", "Echo", "Monty Green", "Harper McIntyre", "Hope Diyoza"] AS spacekruNames
MATCH (f:Faction {name:"Spacekru"})
UNWIND spacekruNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);
WITH ["Bill Cadogan", "Levitt", "Anders", "Bree"] AS disciplesNames
MATCH (f:Faction {name:"The Disciples"})
UNWIND disciplesNames AS pName
MATCH (p:Person {name: pName})
CREATE (p)-[:MEMBER_OF]->(f);

// Lier les lieux de pouvoir et d'origine
MATCH (f:Faction {name:"Trikru"}), (l:Place {name:"Polis"})
CREATE (f)-[:CAPITAL_LOCATED_AT]->(l);
MATCH (f:Faction {name:"Azgeda"}), (l:Place {name:"Ice Nation Capital"})
CREATE (f)-[:CAPITAL_LOCATED_AT]->(l);
MATCH (f:Faction {name:"Skaikru"}), (l:Place {name:"The Ark"})
CREATE (f)-[:ORIGINATED_ON]->(l);
MATCH (f:Faction {name:"Wonkru"}), (l:Place {name:"The Second Dawn Bunker"})
CREATE (f)-[:CONTROLS]->(l);
MATCH (f:Faction {name:"The Disciples"}), (l:Place {name:"Bardo"})
CREATE (f)-[:CONTROLS]->(l);

// Lier les lieux par proximité ou dépendance
MATCH (p1:Place {name:"Arkadia"}), (p2:Place {name:"The Second Dawn Bunker"})
CREATE (p1)-[:NEAR_TO]->(p2);
MATCH (p1:Place {name:"Sanctum"}), (p2:Place {name:"Eligius IV"})
CREATE (p1)-[:ORBITED_BY]->(p2);

// Causalité d'événements
MATCH (e1:Event {name:"Praimfaya"}), (e2:Event {name:"The Conclave"})
CREATE (e1)-[:FORCED_THE_ISSUE_OF]->(e2);
MATCH (e:Event {name:"Massacre at Mount Weather"}), (f:Faction {name:"Mount Weather"})
CREATE (e)-[:DESTROYED]->(f);

// Liens de Concept et Conséquences
MATCH (c:Concept {name:"The Flame"}), (v:Violation {name:"Regicide"})
CREATE (c)-[:CAUSED_CONFLICT_LEADING_TO]->(v);
MATCH (c:Concept {name:"City of Light"}), (v:Violation {name:"Treason"})
CREATE (c)-[:PROMPTED_ACTS_OF]->(v);

// Liens Faction-Lieu
MATCH (f:Faction {name:"Mount Weather"}), (l:Place {name:"Mount Weather"})
CREATE (f)-[:ESTABLISHED_BASE_AT]->(l);
MATCH (f:Faction {name:"Skaikru"}), (l:Place {name:"Arkadia"})
CREATE (f)-[:ESTABLISHED_BASE_AT]->(l);


// Ordre des Saisons (Succession)
MATCH (s1:Season {number:1}), (s2:Season {number:2}) CREATE (s1)-[:SUCCEEDED_BY]->(s2);
MATCH (s2:Season {number:2}), (s3:Season {number:3}) CREATE (s2)-[:SUCCEEDED_BY]->(s3);
MATCH (s3:Season {number:3}), (s4:Season {number:4}) CREATE (s3)-[:SUCCEEDED_BY]->(s4);
MATCH (s4:Season {number:4}), (s5:Season {number:5}) CREATE (s4)-[:SUCCEEDED_BY]->(s5);
MATCH (s5:Season {number:5}), (s6:Season {number:6}) CREATE (s5)-[:SUCCEEDED_BY]->(s6);
MATCH (s6:Season {number:6}), (s7:Season {number:7}) CREATE (s6)-[:SUCCEEDED_BY]->(s7);

// Lier les événements aux saisons
MATCH (e:Event {name:"Praimfaya"}), (s:Season {number:4})
CREATE (e)-[:OCCURRED_DURING]->(s);
MATCH (e:Event {name:"Arrival at Sanctum"}), (s:Season {number:6})
CREATE (e)-[:OCCURRED_DURING]->(s);