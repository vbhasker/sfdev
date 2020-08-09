public inherited sharing abstract class ApplicationSelector extends fflib_SObjectSelector {

    public ApplicationSelector() {
        this(false);
    }

    /**
     * Allows to include fields sets and turn off security validation to capture else where
     * @param includeFieldSetFields
     **/
    public ApplicationSelector(Boolean includeFieldSetFields) {
        this(includeFieldSetFields, false, false);
    }

    /**
     * Removes the default sorting of the fields to aid in performance improvement
     * @param includeFieldSetFields
     * @param enforceCRUD
     * @param enforceFLS
     **/
    public ApplicationSelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS) {
        super(includeFieldSetFields, enforceCRUD, enforceFLS, false);
    }
}