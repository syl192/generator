package ${package.ServiceImpl};

import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

/**
* @author ${author}
* @since ${date}
*/
@Service
@RequiredArgsConstructor
<#if kotlin>
    open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

    }
<#else>
    public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {

<#--@Resource-->
    private final ${table.mapperName} ${(table.mapperName)?uncap_first};

<#--@Override-->
<#--public  IPage<${entity}> findListByPage(Integer page, Integer pageCount){-->
<#--IPage<${entity}> wherePage = new Page<>(page, pageCount);-->
<#--${entity} where = new ${entity}();-->

<#--return   baseMapper.selectPage(wherePage, Wrappers.query(where));-->
<#--}-->

    @Override
    public int add(${entity} ${entity?uncap_first}){
    return baseMapper.insert(${entity?uncap_first});
    }

<#--@Override-->
<#--public int delete(Long id){-->
<#--return baseMapper.deleteById(id);-->
<#--}-->

    @Override
    public int updateData(${entity} ${entity?uncap_first}){
    return baseMapper.updateById(${entity?uncap_first});
    }

    @Override
    public ${entity} findById(Long id){
    return  ${(table.mapperName)?uncap_first}.findById(id);
    }

    }
</#if>
