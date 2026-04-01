package com.ai.facelogin.config;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.postgresql.util.PGobject;
import java.sql.*;
import java.util.Arrays;

public class VectorTypeHandler extends BaseTypeHandler<float[]> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, float[] parameter, JdbcType jdbcType) throws SQLException {
        // float[] -> "[0.1, 0.2, ...]" 형태의 PGobject(vector)로 변환
        PGobject vectorObject = new PGobject();
        vectorObject.setType("vector");
        vectorObject.setValue(Arrays.toString(parameter));
        ps.setObject(i, vectorObject);
    }

    @Override
    public float[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
        return parseVector(rs.getString(columnName));
    }

    @Override
    public float[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return parseVector(rs.getString(columnIndex));
    }

    @Override
    public float[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return parseVector(cs.getString(columnIndex));
    }

    private float[] parseVector(String v) {
        if (v == null) return null;
        // "[0.1,0.2]" -> "0.1,0.2" -> float[]
        String[] s = v.substring(1, v.length() - 1).split(",");
        float[] f = new float[s.length];
        for (int i = 0; i < s.length; i++) f[i] = Float.parseFloat(s[i]);
        return f;
    }

}
