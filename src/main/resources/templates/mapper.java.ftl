package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
* <p>
    * ${entity}Mapper 接口
    * </p>
*
*
* @since ${date}
*/

<#if kotlin>
    interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
    @Mapper
    public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {

    int dynamicInsert(${entity} ${(entity)?uncap_first});

    int deleteByPrimaryKeys(@Param("keys")  List<${entity}> list);

    int dynamicUpdateBatchByPrimaryKeys(List<${entity}> list);

    int dynamicUpdateByPrimaryKey(List<${entity}> list);

    }
</#if>