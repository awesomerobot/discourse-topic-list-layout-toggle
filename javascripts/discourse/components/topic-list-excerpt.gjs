import Component from "@glimmer/component";
import { service } from "@ember/service";

export default class TopicListExcerpt extends Component {
  @service topicListPreference;
  @service router;

  get shouldShow() {
    const currentRoute = this.router.currentRoute.name;
    const isDiscovery = currentRoute.includes("discovery");
    const outlet = this.args.outlet;
    const preference = this.topicListPreference.preference;

    if (isDiscovery) {
      if (
        preference.includes("table-") &&
        outlet === "topic-list-before-category"
      ) {
        return true;
      } else if (
        preference === "cards" &&
        outlet === "topic-list-main-link-bottom"
      ) {
        return true;
      }
    }

    return false;
  }

  get excerpt() {
    const topic = this.args.topic;
    const gist = topic?.ai_topic_gist;
    const excerpt = topic?.excerpt;
    const preference = this.topicListPreference.preference;

    switch (preference) {
      case "table-excerpts":
        return excerpt;
      case "table-ai":
        return gist;
      case "cards":
        return gist || (excerpt?.length ? excerpt : null);
      default:
        return null;
    }
  }

  <template>
    {{#if this.shouldShow}}
      {{#if this.excerpt}}
        <div class="excerpt">
          <div>{{this.excerpt}}</div>
        </div>
      {{/if}}
    {{/if}}
  </template>
}
