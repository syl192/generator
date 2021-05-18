<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">
    <#if enableCache>
        <!-- 开启二级缓存 -->
        <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>
    </#if>
    <#if baseResultMap>
        <!-- 通用查询映射结果 -->
        <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
            <#list table.fields as field>
                <#if field.keyFlag><#--生成主键排在第一位-->
                    <id column="${field.name}" property="${field.propertyName}"/>
                </#if>
            </#list>
            <#list table.commonFields as field><#--生成公共字段 -->
                <result column="${field.name}" property="${field.propertyName}"/>
            </#list>
            <#list table.fields as field>
                <#if !field.keyFlag><#--生成普通字段 -->
                    <result column="${field.name}" property="${field.propertyName}"/>
                </#if>
            </#list>
        </resultMap>
    </#if>
        <!-- 通用查询结果 -->
        <sql id="${table.name}_list">
            <#list table.commonFields as field>
                ${field.name},
            </#list>
            ${table.fieldNames}
        </sql>
        
        <sql id="${table.name}_group_list">
            <#list table.fields as field><#if field.keyFlag>${field.name}</#if><#if !field.keyFlag><#noparse>any_value(</#noparse>${field.name}<#noparse>)</#noparse> ${field.name}</#if>,</#list>
        </sql>
        
    <!-- 动态插入 -->
    <insert id="dynamicInsert">
        INSERT INTO ${table.name} (
        <trim suffixOverrides=",">
            <#list table.fields as field>
                <if test='${field.propertyName} != null '>${field.name},</if>
            </#list>
        </trim>
        ) VALUE (
        <trim suffixOverrides=",">
            <#list table.fields as field>
                <if test='${field.propertyName} != null '><#noparse>#{</#noparse>${field.propertyName}<#noparse>}</#noparse>,</if>
            </#list>
        </trim>
        )
    </insert>

    <!--int deleteByPrimaryKeys(@Param("keys") List<primaryKeyType> list, ...)> -->
    <delete id="deleteByPrimaryKeys">
        DELETE FROM ${table.name} WHERE <#list table.fields as field><#if field.keyFlag>${field.name}</#if></#list> IN
        <foreach collection="keys" open="(" close=")" item="item" separator="," index="index">
            <#noparse>#{</#noparse>item<#noparse>}</#noparse>
        </foreach>
        <choose>
            <when test="state == 1"> AND name = <#noparse>#{</#noparse>name1<#noparse>}</#noparse> </when>
            <when test="state == 2"> AND name = <#noparse>#{</#noparse>name2<#noparse>}</#noparse> </when>
            <otherwise> AND name = <#noparse>#{</#noparse>name3<#noparse>}</#noparse> </otherwise>
        </choose>
    </delete>

    <!--int updateBatch(List<${entity}> list)> -->
    <update id="dynamicUpdateBatchByPrimaryKeys">
        UPDATE ${table.name}
        <trim prefix="set" suffixOverrides=",">
            <#list table.fields as field>
                <#if !field.keyFlag>
                    <trim prefix="${field.name} = CASE" suffix="END,">
                        <foreach collection="list" item="item">
                            <if test='item.${field.propertyName} != null'>
                                WHEN <#list table.fields as field1><#if field1.keyFlag>${field1.name} = <#noparse>#{item.</#noparse>${field1.propertyName}<#noparse>}</#noparse></#if></#list > THEN <#noparse>#{item.</#noparse>${field.propertyName}<#noparse>}</#noparse>
                            </if>
                        </foreach>
                    </trim>
                </#if>
            </#list>
        </trim>
        WHERE <#list table.fields as field><#if field.keyFlag>${field.name} IN
            <foreach collection="list" open="(" close=")" separator="," item="item" index=""> <#noparse>#{item.</#noparse>${field.propertyName}<#noparse>}</#noparse> </foreach>
        </#if></#list>
    </update>

    <update id="dynamicUpdateByPrimaryKey">
        UPDATE ${table.name}
        <trim prefix="SET" suffixOverrides=",">
            <#list table.fields as field><#if !field.keyFlag>
                <if test='${field.propertyName} != null '>${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>},</#noparse></if>
            </#if></#list>
        </trim>
        WHERE <#list table.fields as field><#if field.keyFlag>${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>}</#noparse></#if></#list>
    </update>

</mapper>