-- Total Seats

SELECT
DISTINCT COUNT(Parliament_Constituency) AS Total_Seats
FROM constituencywise_results

-- Number of seats available for elections in each state

SELECT S.State AS State_Name, 
COUNT (CR.Parliament_Constituency) AS Total_Seats
FROM constituencywise_results AS CR
INNER JOIN statewise_results AS SR
ON CR.Parliament_Constituency = SR.Parliament_Constituency
INNER JOIN States AS S
ON SR.State_ID = S.State_ID
GROUP BY S.State


--Total Seats won by NDA Alliance
SELECT 
SUM(CASE 
WHEN party IN (
                'Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)','Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP','Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM') 
                THEN [Won]
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_results



    -- Seats Won by NDA Allianz Parties
SELECT party as Party_Name,
    won as Seats_Won
FROM partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 'AJSU Party - AJSUP', 'Apna Dal (Soneylal) - ADAL', 'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',  'Nationalist Congress Party - NCP','Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
    ORDER BY Seats_Won DESC



-- Total Seats Won by I.N.D.I.A. Allianz

    SELECT 
    SUM(CASE 
        WHEN party IN ('Indian National Congress - INC','Aam Aadmi Party - AAAP','All India Trinamool Congress - AITC',
                       'Bharat Adivasi Party - BHRTADVSIP','Communist Party of India  (Marxist) - CPI(M)',
                       'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                       'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                       'Nat`Jammu & Kashmir National Conference - JKN','Jharkhand Mukti Morcha - JMM',
                       'Jammu & Kashmir National Conference - JKN','Kerala Congress - KEC','Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                       'Nationalist Congress Party Sharadchandra Pawar - NCPSP','Rashtriya Janata Dal - RJD',
                       'Rashtriya Loktantrik Party - RLTP','Revolutionary Socialist Party - RSP','Samajwadi Party - SP',
                       'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT','Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results



    -- Seats won by INDIA Allianz Parties

    SELECT party as Party_Name,
    won as Seats_Won
    FROM partywise_results
    WHERE 
    party IN ('Indian National Congress - INC','Aam Aadmi Party - AAAP','All India Trinamool Congress - AITC',
                       'Bharat Adivasi Party - BHRTADVSIP','Communist Party of India  (Marxist) - CPI(M)',
                       'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                       'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                       'Nat`Jammu & Kashmir National Conference - JKN','Jharkhand Mukti Morcha - JMM',
                       'Jammu & Kashmir National Conference - JKN','Kerala Congress - KEC','Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                       'Nationalist Congress Party Sharadchandra Pawar - NCPSP','Rashtriya Janata Dal - RJD',
                       'Rashtriya Loktantrik Party - RLTP','Revolutionary Socialist Party - RSP','Samajwadi Party - SP',
                       'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT','Viduthalai Chiruthaigal Katchi - VCK'
            )
            ORDER BY Seats_Won DESC



-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

ALTER TABLE partywise_results
ADD party_alliance VARCHAR (50)

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC','Aam Aadmi Party - AAAP','All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP','Communist Party of India  (Marxist) - CPI(M)','Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI','Dravida Munnetra Kazhagam - DMK',	'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN','Jharkhand Mukti Morcha - JMM','Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK','Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD','Rashtriya Loktantrik Party - RLTP','Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP','Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT','Viduthalai Chiruthaigal Katchi - VCK'
)


UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP','Telugu Desam - TDP','Janata Dal  (United) - JD(U)','Shiv Sena - SHS',
    'AJSU Party - AJSUP','Apna Dal (Soneylal) - ADAL','Asom Gana Parishad - AGP','Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP','Janata Dal  (Secular) - JD(S)','Lok Janshakti Party(Ram Vilas) - LJPRV','Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD','Sikkim Krantikari Morcha - SKM')


UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL


-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

SELECT party_alliance,
SUM(Won)
FROM partywise_results
GROUP BY party_alliance

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT
C.Winning_Candidate, 
P.party AS Party_name,
P.party_alliance,
C.Total_Votes,
C.Margin,
S.State,
C.Constituency_Name
FROM constituencywise_results AS C
INNER JOIN partywise_results AS P
ON C.Party_ID = P.Party_ID
INNER JOIN statewise_results AS SR
ON C.Parliament_Constituency = SR.Parliament_Constituency
INNER JOIN states AS S 
ON SR.State_ID = S.State_ID
WHERE C.Constituency_Name = 'BARAMATI'

-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?


SELECT 
cd.Candidate,
cd.Party,
cd.EVM_Votes,
cd.Postal_Votes,
cd.Total_Votes,
cr.Constituency_Name
FROM 
constituencywise_details cd
INNER JOIN 
constituencywise_results cr 
ON cd.Constituency_ID = cr.Constituency_ID
WHERE 
cr.Constituency_Name = 'MATHURA'
ORDER BY cd.Total_Votes DESC


-- Which parties won the most seats in s State, and how many seats did each party win?

SELECT 
p.Party,
COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
constituencywise_results cr
INNER JOIN 
partywise_results p ON cr.Party_ID = p.Party_ID
INNER JOIN 
statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN states s ON sr.State_ID = s.State_ID
WHERE 
s.state = 'Andhra Pradesh'
GROUP BY 
p.Party
ORDER BY 
Seats_Won DESC




-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT 
s.State AS State_Name,
SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
constituencywise_results cr
INNER JOIN 
partywise_results AS p ON cr.Party_ID = p.Party_ID
INNER JOIN 
statewise_results AS sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN 
states AS s ON sr.State_ID = s.State_ID
WHERE 
p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
s.State
ORDER BY 
s.State


-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?


WITH RankedCandidates AS (
SELECT 
cd.Constituency_ID,
cd.Candidate,
cd.Party,
cd.EVM_Votes,
cd.Postal_Votes,
cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID 
ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
FROM 
constituencywise_details cd
INNER JOIN 
constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
INNER JOIN 
statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN 
states s ON sr.State_ID = s.State_ID
WHERE 
s.State = 'Maharashtra'
)

SELECT 
cr.Constituency_Name,
MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
RankedCandidates rc
INNER JOIN 
constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
cr.Constituency_Name
ORDER BY 
cr.Constituency_Name



