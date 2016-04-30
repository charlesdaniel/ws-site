/* jshint expr:true */
import { expect } from 'chai';
import {
  describeComponent,
  it
} from 'ember-mocha';
import hbs from 'htmlbars-inline-precompile';

describeComponent(
  'code-block',
  'Integration: CodeBlockComponent',
  {
    integration: true
  },
  function() {
    it('renders', function() {
      // Set any properties with this.set('myProperty', 'value');
      // Handle any actions with this.on('myAction', function(val) { ... });
      // Template block usage:
      // this.render(hbs`
      //   {{#code-block}}
      //     template content
      //   {{/code-block}}
      // `);

      this.render(hbs`{{code-block}}`);
      expect(this.$()).to.have.length(1);
    });
  }
);
