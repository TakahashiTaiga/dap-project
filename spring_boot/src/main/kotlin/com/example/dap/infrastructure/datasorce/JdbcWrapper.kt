package com.example.dap.infrastructure.datasorce

class JdbcWrapper(
    private val jdbcTemplate: JdbcTemplate
) {
    private val jdbc = NamedParamaterJdbcTemplate(jdbcTemplate)
    private val generatedKeyHolder: GeneratedKeyHolder = GeneratedKeyHolder()

    fun <T> selectForObject(query: String, param: SqlParamaterSource, clazz: Class<T>): T? {
        return try {
            jdbc.queryForObject<T>(query, param, DataClassRowMapper(clazz))
        } catch (e: EmptyResultDataAccessException) {
            null
        }
    }

    fun <T> selectForList(query: String, param: SqlParamaterSource, clazz: Class<T>): List<T> {
        return try {
            jdbc.queryForList<T>(query, param, DataClassRowMapper(clazz))
        } catch (e: EmptyResultDataAccessException) {
            emptyList()
        }
    }

    fun insert(query: String, insertObject: SqlParameterSource): Long {
        jdbc.update(query, insertObject, generatedKeyHolder)
        return generatedKeyHolder.getKey()!!.toLong()
    }

    fun update(query: String, updateObject: SqlParameterSource): Int {
        return jdbc.update(query, updateObject)
    }

    fun delete(query: String, deleteObject: SqlParameterSource) {
        jdbc.update(query, deleteObject)
        return
    }
}