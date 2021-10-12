module.exports = f => {
    f.id = f.properties.Village_ID
    const props = {}
    for (const key in f.properties) {
        let newKey = key.toLowerCase()
        switch (newKey) {
            case 'distr_id':
                newKey = 'district_id'
                break
            case 'prov_id':
                newKey = 'province_id'
                break
            case 'name':
                newKey = 'village'
                break
            default:
                break
        }
        props[newKey] = f.properties[key]
    }
    f.properties = props
    f.tippecanoe = {
        minzoom: 0,
        maxzoom: 16,
        layer: 'rw_villages'
    }
    return f
}