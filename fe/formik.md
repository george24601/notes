

### Dependent field:
Custom props, touched, setField value

Like errors and values, Formik keeps track of which fields have been visited. It stores this information in an object called touched that also mirrors the shape of values/initialValues. The keys of touched are the field names, and the values of touched are booleans true/false.

To take advantage of touched, we pass formik.handleBlur to each input’s onBlur prop. This function works similarly to formik.handleChange in that it uses the name attribute to figure out which field to update.

extC is still editable after being set programmatically. However, the value will be overwritten if/whenever there are (new) changes to textA and textB. This is because of the dependency array in our custom field's React.useEffect; it only runs when textA or textB change or have been touched. Since Formik's `setFieldValue` is equivalent between renders and so is the field's name prop, this works as expected. You could alter this overrwriting behavior by keeping track of whether textC was been updated by field.onChange or useEffect. This might be very useful if you want to alert the end user that their changes to textC will be lost.


With Formik, you can and should build reusable input primitive components that you can share around your application. Turns out our <Field> render-prop component has a sister and her name is useField that’s going to do the same thing, but via React Hooks

useFormik() returns a helper method called formik.getFieldProps() to make it faster to wire up inputs. Given some field-level info, it returns to you the exact group of onChange, onBlur, value, checked for a given field. You can then spread that on an input, select, or textarea.

```javascript
     <input
         id="firstName"
         type="text"
         {...formik.getFieldProps('firstName')}
       />
```

Formik comes with React Context-powered API/components to make life easier and code less verbose: <Formik />, <Form />, <Field />, and <ErrorMessage />. More explicitly, they use React Context implicitly to connect with the parent <Formik /> state/methods.

we swapped out useFormik() hook and replaced it with the <Formik> component. The <Formik> component accepts a function as its children (a.k.a. a render prop). Its argument is the exact same object returned by useFormik() (in fact, <Formik> calls useFormik() internally!)

The <Field> component by default will render an <input> component that, given a name prop, will implicitly grab the respective onChange, onBlur, value props and pass them to the element as well as any props you pass to it. However, since not everything is an input, <Field> also accepts a few other props to let you render whatever you want. 

Formik keeps track of your form's state and then exposes it plus a few reusable methods and event handlers (handleChange, handleBlur, and handleSubmit) to your form via props. handleChange and handleBlur work exactly as expected--they use a name or id attribute to figure out which field to update.
