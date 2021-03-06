{-
    flatmap.io IT job search based on geo and technology.
    Copyright (C) 2019 Vadim Bakaev

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}

module Model where

import ClassyPrelude.Yesod
import Database.Persist.MongoDB hiding (master)
import Database.Persist.Quasi
import Language.Haskell.TH.Syntax

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
let mongoSettings = mkPersistSettings (ConT ''MongoContext)
 in share
      [mkPersist mongoSettings]
      $(persistFileWith upperCaseSettings "config/models")

langs :: [Text]
langs =
  [ "Agda"
  , "Csharp"
  , "Clojure"
  , "Coq"
  , "Cpp"
  , "D"
  , "Dart"
  , "Elixir"
  , "Elm"
  , "Erlang"
  , "Fsharp"
  , "Groovy"
  , "Haskell"
  , "Idris"
  , "Java"
  , "JavaScript"
  , "Julia"
  , "Kotlin"
  , "Nim"
  , "OCaml"
  , "PHP"
  , "Perl"
  , "PureScript"
  , "Python"
  , "R"
  , "Racket"
  , "Ruby"
  , "Rust"
  , "Scala"
  , "TypeScript"
  ]

industries :: [Text]
industries =
  [ "Accounting"
  , "Airlines/Aviation"
  , "Alternative Dispute Resolution"
  , "Alternative Medicine"
  , "Animation"
  , "Apparel & Fashion"
  , "Architecture & Planning"
  , "Arts and Crafts"
  , "Automotive"
  , "Aviation & Aerospace"
  , "Banking"
  , "Biotechnology"
  , "Broadcast Media"
  , "Building Materials"
  , "Business Supplies and Equipment"
  , "Capital Markets"
  , "Chemicals"
  , "Civic & Social Organization"
  , "Civil Engineering"
  , "Commercial Real Estate"
  , "Computer & Network Security"
  , "Computer Games"
  , "Computer Hardware"
  , "Computer Networking"
  , "Computer Software"
  , "Construction"
  , "Consumer Electronics"
  , "Consumer Goods"
  , "Consumer Services"
  , "Cosmetics"
  , "Dairy"
  , "Defense & Space"
  , "Design"
  , "Education Management"
  , "E-Learning"
  , "Electrical/Electronic Manufacturing"
  , "Entertainment"
  , "Environmental Services"
  , "Events Services"
  , "Executive Office"
  , "Facilities Services"
  , "Farming"
  , "Financial Services"
  , "Fine Art"
  , "Fishery"
  , "Food & Beverages"
  , "Food Production"
  , "Fund-Raising"
  , "Furniture"
  , "Gambling & Casinos"
  , "Glass, Ceramics & Concrete"
  , "Government Administration"
  , "Government Relations"
  , "Graphic Design"
  , "Health, Wellness and Fitness"
  , "Higher Education"
  , "Hospital & Health Care"
  , "Hospitality"
  , "Human Resources"
  , "Import and Export"
  , "Individual & Family Services"
  , "Industrial Automation"
  , "Information Services"
  , "Information Technology and Services"
  , "Insurance"
  , "International Affairs"
  , "International Trade and Development"
  , "Internet"
  , "Investment Banking"
  , "Investment Management"
  , "Judiciary"
  , "Law Enforcement"
  , "Law Practice"
  , "Legal Services"
  , "Legislative Office"
  , "Leisure, Travel & Tourism"
  , "Libraries"
  , "Logistics and Supply Chain"
  , "Luxury Goods & Jewelry"
  , "Machinery"
  , "Management Consulting"
  , "Maritime"
  , "Market Research"
  , "Marketing and Advertising"
  , "Mechanical or Industrial Engineering"
  , "Media Production"
  , "Medical Devices"
  , "Medical Practice"
  , "Mental Health Care"
  , "Military"
  , "Mining & Metals"
  , "Motion Pictures and Film"
  , "Museums and Institutions"
  , "Music"
  , "Nanotechnology"
  , "Newspapers"
  , "Non-Profit Organization Management"
  , "Oil & Energy"
  , "Online Media"
  , "Outsourcing/Offshoring"
  , "Package/Freight Delivery"
  , "Packaging and Containers"
  , "Paper & Forest Products"
  , "Performing Arts"
  , "Pharmaceuticals"
  , "Philanthropy"
  , "Photography"
  , "Plastics"
  , "Political Organization"
  , "Primary/Secondary Education"
  , "Printing"
  , "Professional Training & Coaching"
  , "Program Development"
  , "Public Policy"
  , "Public Relations and Communications"
  , "Public Safety"
  , "Publishing"
  , "Railroad Manufacture"
  , "Ranching"
  , "Real Estate"
  , "Recreational Facilities and Services"
  , "Religious Institutions"
  , "Renewables & Environment"
  , "Research"
  , "Restaurants"
  , "Retail"
  , "Security and Investigations"
  , "Semiconductors"
  , "Shipbuilding"
  , "Sporting Goods"
  , "Sports"
  , "Staffing and Recruiting"
  , "Supermarkets"
  , "Telecommunications"
  , "Textiles"
  , "Think Tanks"
  , "Tobacco"
  , "Translation and Localization"
  , "Transportation/Trucking/Railroad"
  , "Utilities"
  , "Venture Capital & Private Equity"
  , "Veterinary"
  , "Warehousing"
  , "Wholesale"
  , "Wine and Spirits"
  , "Wireless"
  , "Writing and Editing"
  ]
