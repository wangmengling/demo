//
//  SrorageToSQLite.swift
//  demo
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//
//        let blobTypes = ["BINARY", "BLOB", "VARBINARY"]
//        let charTypes = ["CHAR", "CHARACTER", "CLOB", "NATIONAL VARYING CHARACTER", "NATIVE CHARACTER", "NCHAR", "NVARCHAR", "TEXT", "VARCHAR", "VARIANT", "VARYING CHARACTER"]
//        //        let davarypes = ["DATE", "DATETIME", "TIME", "TIMESTAMP"]
//        let intTypes  = ["BIGINT", "BIT", "BOOL", "BOOLEAN", "INT", "INT2", "INT8", "INTEGER", "MEDIUMINT", "SMALLINT", "TINYINT"]
//        let nullTypes = ["NULL"]
//        let realTypes = ["DECIMAL", "DOUBLE", "DOUBLE PRECISION", "FLOAT", "NUMERIC", "REAL"]

import Foundation

struct SrorageToSQLite {
    internal typealias E = DataConversionProtocol
    var sqliteManager = SQLiteManager.instanceManager
    
    static let instanceManager:SrorageToSQLite = {
        return SrorageToSQLite()
    }()
    
    mutating func objectToSQLite(object:E) -> [[String : AnyObject]] {
        let objectsMirror = Mirror(reflecting: object)
        let selectSQL = "SELECT * FROM  \(String(objectsMirror.subjectType));"
        return sqliteManager.fetchArray(selectSQL)
    }
}


extension SrorageToSQLite {
    
}

// MARK: - Insert Data To Table
extension SrorageToSQLite {
    
    
    func insert(object:E) -> Bool {
        
        let objectsMirror = Mirror(reflecting: object)
        let property = objectsMirror.children
        
        var columns = ""
        var values = ""
        
        
        if let b = AnyBidirectionalCollection(property) {
                for i in b.endIndex.advancedBy(-20, limit: b.startIndex)..<b.endIndex {
                    let child = b[i]
                    
                    guard let columnValue:String = self.proToColumnValues(child.value) where columnValue.characters.count > 0  else  {
                        continue
//                        return false
                    }
                    columns += "\(child.label!),"
                    values += columnValue
            }
        }
        
        if property.count > 0 {
            columns = columns.subString(0, length: columns.characters.count - 1)
            values = values.subString(0, length: values.characters.count - 1)
        }
        
        let insertSQL = "INSERT INTO \(String(objectsMirror.subjectType)) (\(columns))  VALUES (\(values));"
        return sqliteManager.execSQL(insertSQL)
    }
    
    
    
    /**
     Optional To Value
     
     - parameter value: 属性值
     
     - returns: column values
     */
    func proToColumnValues(value:Any) -> String{
        
        guard let x:Any? = value else {
            return ""
        }
        
        if x.debugDescription == "Optional(nil)" {
            return ""
        }
        
        let m =  Mirror(reflecting: value)
        
        if m.subjectType == Optional<Int>.self{
            return "\(value as! Int),"
        } else if m.subjectType == Optional<Double>.self{
            return "\(value as! Double),"
        } else if m.subjectType == Optional<Float>.self{
            return "\(value as! Float),"
        } else if m.subjectType == Optional<String>.self{
            return "'\(value as! String)',"
        } else if m.subjectType == String.self {
            return "'\(value)',"
        } else {
            return "\(value),"
        }
    }
}

// MARK: - Create Table
extension SrorageToSQLite {
    /**
     check table is exist
     
     - parameter object: E object
     
     - returns: Bool
     */
    func tableIsExists(object:E) -> Bool {
        let objectsMirror = Mirror(reflecting: object)
        let sqls = "SELECT count(*) FROM sqlite_master WHERE type='table' AND name='\(String(objectsMirror.subjectType))'"
        return sqliteManager.execSQL(sqls)
    }
    
    /**
     create table
     
     - parameter object: E object
     */
    func createTable(object:E) -> Bool {
        /// 1.反射获取属性
        let objectsMirror = Mirror(reflecting: object)
        let property = objectsMirror.children
        
        /// 2.设置插入字段
        var column = ""
        _ = property.map { (label,value) -> Void in
            column += self.proToColumn(label!, value: value)
        }
        if column.characters.count > 5 {
            column = column.subString(0, length: column.characters.count - 1)
        }
        let createTabelSQL = "Create TABLE if not exists \(String(objectsMirror.subjectType))(\(column));"
        
        /// 3.执行createTableSql
        return sqliteManager.execSQL(createTabelSQL)
    }
    
    /**
     SQLite Column Type
     
     - CHARACTER: CHARACTER description
     - INT:       INT description
     - FLOAT:     FLOAT description
     - DOUBLE:    DOUBLE description
     - INTEGER:   INTEGER description
     - BLOB:      BLOB description
     - NULL:      NULL description
     - TEXT:      TEXT description
     */
    enum ColumuType: String {
        case CHARACTER,INT,FLOAT,DOUBLE,INTEGER,BLOB,NULL,TEXT
    }
    
    /**
     Create Table Column Structure ---- E object property To Column SQL
     
     - parameter label: object property
     - parameter value: object property value
     
     - returns: SQL
     */
    func proToColumn(label:String,value:Any) -> String {
        var string = ""
        let columuType = self.typeReplace(value)
        switch columuType {
        case ColumuType.INT:
            string += "\(label) \(ColumuType.INT.rawValue) ,"
        case ColumuType.DOUBLE:
            string += "\(label) \(ColumuType.DOUBLE.rawValue) ,"
        case ColumuType.FLOAT:
            string += "\(label) \(ColumuType.FLOAT.rawValue) ,"
        case ColumuType.CHARACTER:
            string += "\(label) \(ColumuType.CHARACTER.rawValue)(255) ,"
        default:
            return string
        }
        return string
    }
    
    /**
     type replace [eg:String To CHARACTER]
     
     - parameter value: AnyObject.Type
     
     - returns: Column Type
     */
    func typeReplace(value:Any) -> ColumuType {
        guard let x:Any = value else {
            return ColumuType.NULL
        }
        
        let m =  Mirror(reflecting: x)
        
        if m.subjectType ==  Int.self || m.subjectType == Optional<Int>.self{
            return ColumuType.INT
        } else if m.subjectType ==  Double.self || m.subjectType == Optional<Double>.self{
            return ColumuType.DOUBLE
        } else if m.subjectType ==  Float.self || m.subjectType == Optional<Float>.self{
            return ColumuType.FLOAT
        } else if m.subjectType ==  String.self || m.subjectType == Optional<String>.self{
            return ColumuType.CHARACTER
        }
        
        return ColumuType.NULL
    }
}