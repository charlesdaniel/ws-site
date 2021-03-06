/* jshint expr:true */
import { expect } from 'chai';
import {
  describeComponent,
  it
} from 'ember-mocha';
import hbs from 'htmlbars-inline-precompile';

describeComponent(
  'autobahn-test-list',
  'Integration: AutobahnTestListComponent',
  {
    integration: true
  },
  function() {
    it('renders', function() {
      // Set any properties with this.set('myProperty', 'value');
      // Handle any actions with this.on('myAction', function(val) { ... });
      // Template block usage:
      // this.render(hbs`
      //   {{#autobahn-test-list}}
      //     template content
      //   {{/autobahn-test-list}}
      // `);

      this.render(hbs`{{autobahn-test-list}}`);
      expect(this.$()).to.have.length(1);
    });
  }
);
